if Sections.find().count() == 0
    sections = ({
        _id: num.toString()
        name: 'Section no. ' + num
        description: 'Description of section no. ' + num
    } for num in [1..6])

    Sections.insert section for section in sections
