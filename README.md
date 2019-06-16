# hackforgood

Model sourcecode can be found in the src directory of this repository

## Translaters without borders impact classifier

### Usage:

  ```
  model.py train
  model.py validate
  model.py server
  model.py predict <text>
  ```

### Options:

  ```
  -h --help     Show this screen.
  train         Trains with the specified dataset and classifier.
  validate      Run cross validation on the training set
  server        Run API server
  predict       Text to predict
  ```
  
### Examples:

Train and test the machine learning model

```bash
python model.py train
```

### Call API server:

Predict with the text "predict this text"

```bash
curl --request POST \
  --url 'http://127.0.0.1:5000/predict?text=predict%20this%20text&='
```
