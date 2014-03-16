getFixtures = -> [
  collection: Categories
  documents: [
    name: 'Mushrooms'
  ]
,
  collection: Items
  documents: []
]

Meteor.startup ->
  loadFixtures()

Meteor.methods
  'reset': ->
    reset()
    loadFixtures()

loadFixtures = ->
  for fixture in getFixtures()
    collection = fixture.collection
    if collection.find().count() ==  0
      for document in fixture.documents
        collection.insert document

reset = ->
  for fixture in getFixtures()
    fixture.collection.remove {}

