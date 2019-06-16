# hackforgood
##Translaters without borders impact classifier

###Usage:
  model.py train
  model.py validate
  model.py server
  model.py predict <text>

###Options:
  -h --help     Show this screen.
  train         Trains with the specified dataset and classifier.
  validate      Run cross validation on the training set
  server        Run API server
  predict       Text to predict
  
###Examples:

    Train and test the machine learning model
    - python model.py train