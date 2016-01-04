module.exports 'sequenceControl',
    # próbuje dodać do sekwencji kolejny krok
    # jeśli nie pasuje, to resetuje sekwencję (trzeba zacząć od nowa)
    tryAddNextStep: (stepNumber, informations) ->
        currentUserId = Meteor.userId()
        # jeśli user nie gromadził jeszcze sekwencji
        unless sequenceSteps.currentUserId?
            sequenceSteps.currentUserId = { }

        switch stepNumber
            when 1
                console.log 'STEP1 processing...'
                # pierwszy krok zaliczamy zawsze po zgłoszeniu
                sequenceSteps.currentUserId =
                    step: 1
                    postText: informations.text
                    stepPassedAt: informations.createdAt
                console.log 'STEP1 passed!'
            when 2
                console.log 'STEP2 processing...'
                # przejdź dalej tylko jeśli aktualnym krokiem jest 1.
                # jeśli nie, resetuj sekwencję dla tego użytkownika
                unless sequenceSteps.currentUserId.step == 1
                    sequenceSteps.currentUserId = { }
                    return
                
                # oblicz różnicę czasu w sekundach od poprzedniego kroku
                timeDifference = (informations.updatedAt - sequenceSteps.currentUserId.stepPassedAt)/10000
                
                # drugi krok jest ważny po upływie co najwyżej 10 sekund od pierwszego
                # polega on na update'cie posta bez zmiany treści
                if informations.text == sequenceSteps.currentUserId.postText && 0 < timeDifference <= 10
                    sequenceSteps.currentUserId.step = 2
                    sequenceSteps.currentUserId.stepPassedAt = informations.updatedAt
                    console.log 'STEP2 passed!'
                else
                    # jeśli nie spełniono warunków, resetuj sekwencję
                    sequenceSteps.currentUserId = { }
            when 3
                console.log 'STEP3 processing...'
                # przejdź dalej tylko jeśli aktualnym krokiem jest 2.
                # jeśli nie, resetuj sekwencję dla tego użytkownika
                unless sequenceSteps.currentUserId.step == 2
                    sequenceSteps.currentUserId = { }
                    return
                
                # oblicz różnicę czasu w sekundach od poprzedniego kroku
                timeDifference = (informations.updatedAt - sequenceSteps.currentUserId.stepPassedAt)/10000

                # trzeci krok jest ważny po upływie co najwyżej 10 sekund od drugiego
                # polega on na update'cie w profilu użytkownika liczby lat jego kota liczbą wyrazów,
                # z których składa się pierwotny post z początku sekwencji
                if true && 0 < timeDifference <= 10
                    sequenceSteps.currentUserId.step = 3
                    console.log 'STEP3 passed!'
                else
                    # jeśli nie spełniono warunków, resetuj sekwencję
                    sequenceSteps.currentUserId = { }
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
