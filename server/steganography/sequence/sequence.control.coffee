module.exports 'sequenceControl',
    # prywatna funkcja, która sprawdza, czy użytkownik osiągnął poprzedni krok sekwencji
    # oraz czy z osiąganiem kolejnego "wyrobił się" w czasie
    _checkStep: (number, informations, updatedAtMost = 10) ->
        currentUserId = Meteor.userId()
        # przejdź dalej tylko jeśli aktualnym krokiem jest number 
        # jeśli nie, resetuj sekwencję dla tego użytkownika
        unless sequenceSteps.currentUserId.step == number
            sequenceSteps.currentUserId = { }
            return false
        
        # oblicz różnicę czasu w sekundach od poprzedniego kroku
        timeDifference = (informations.updatedAt - sequenceSteps.currentUserId.stepPassedAt)/1000
        
        return 0 < timeDifference <= updatedAtMost
    # próbuje dodać do sekwencji kolejny krok
    # jeśli nie pasuje, to resetuje sekwencję (trzeba zacząć od nowa)
    tryAddNextStep: (stepNumber, informations) ->
        currentUserId = Meteor.userId()
        # jeśli user nie gromadził jeszcze sekwencji
        unless sequenceSteps.currentUserId?
            sequenceSteps.currentUserId = { }

        switch stepNumber
            when 1
                # pierwszy krok zaliczamy zawsze po zgłoszeniu
                sequenceSteps.currentUserId =
                    step: 1
                    postText: informations.text
                    stepPassedAt: informations.createdAt
            when 2
                # upewnij się, że użytkownik wykonał poprzednie kroki sekwencji
                return unless this._checkStep(1, informations)
                
                # drugi krok jest ważny po upływie co najwyżej 10 sekund od pierwszego
                # polega on na update'cie posta bez zmiany treści
                if informations.text == sequenceSteps.currentUserId.postText
                    sequenceSteps.currentUserId.step = 2
                    sequenceSteps.currentUserId.stepPassedAt = informations.updatedAt
                else
                    # jeśli nie spełniono warunków, resetuj sekwencję
                    this.resetStepsForUser(currentUserId)
            when 3
                # upewnij się, że użytkownik wykonał poprzednie kroki sekwencji
                return unless this._checkStep(2, informations)

                # ile wyrazów było w poście na początku sekwencji?
                postWordsCount = sequenceSteps.currentUserId.postText.split(' ').length.toString()

                # trzeci krok jest ważny po upływie co najwyżej 10 sekund od drugiego
                # polega on na update'cie w profilu użytkownika liczby lat jego kota liczbą wyrazów,
                # z których składa się pierwotny post z początku sekwencji
                if informations.catyears == postWordsCount
                    sequenceSteps.currentUserId.step = 3
                else
                    # jeśli nie spełniono warunków, resetuj sekwencję
                    this.resetStepsForUser(currentUserId)
    statusForUser: (userId) ->
        currentStep = sequenceSteps.currentUserId.step
        switch currentStep
            when undefined then 'Empty'
            when 1, 2 then      'In progress'
            when 3 then         'Completed'
    resetStepsForUser: (userId) ->
        sequenceSteps.currentUserId = { }

# przechowuje informacje o tym, w którym miejscu sekwencji znajdują się wszyscy użytkownicy
sequenceSteps = { }
