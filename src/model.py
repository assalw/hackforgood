"""Translaters without borders impact classifier

Usage:
  model.py train
  model.py validate
  model.py server
  model.py predict <text>

Options:
  -h --help     Show this screen.
  train         Trains with the specified dataset and classifier.
  validate      Run cross validation on the training set
  server        Run API server
  predict       Text to predict
  
Examples:

    Train and test the machine learning model
    - python model.py train
"""


import sys, os, logging
from docopt import docopt
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.pipeline import FeatureUnion
from sklearn.ensemble import AdaBoostClassifier
from sklearn.pipeline import Pipeline
from sklearn.datasets import load_files
from sklearn import metrics
from sklearn.preprocessing import MaxAbsScaler
from sklearn.model_selection import train_test_split, StratifiedKFold, cross_val_score
from sklearn.metrics import classification_report, accuracy_score, make_scorer
import pickle

import numpy as np
import pandas as pd

from flask import Flask
from flask import request
from flask import json

# Flask app
app = Flask(__name__)

# To get stable experimental result
RANDOM_STATE = 66

# Read dataset
input_file = "../dataset/train_labels.xlsx"
dataset_df = pd.read_excel(input_file, header = 0)

# Trim whitespaces from column names
dataset_df.rename(columns=lambda x: x.strip(), inplace = True)

# put the original column names in a python list
original_headers = list(dataset_df.columns.values)

# put the numeric column names in a python list TODO: Should put filename back in
features = dataset_df['sourcetext']
feature_cols = list(dataset_df.columns.values)

# Target column and data
target_cols = ['impact']
target = dataset_df['impact']

# split the dataset in training and test set:
x_train, x_test, y_train, y_test = train_test_split(
    features, target, test_size=0.20, random_state=RANDOM_STATE)

# Model pipeline
features_pipeline = ('features', FeatureUnion([
        ('vect_w', TfidfVectorizer(min_df=0, max_df=1, analyzer="word", ngram_range=(1, 2))),
        ('vect_c', TfidfVectorizer(min_df=0, max_df=1, analyzer="char", ngram_range=(1, 2))),
        ('vec', CountVectorizer()),
    ]))

classifier = ("AB", AdaBoostClassifier(n_estimators=250))

scaler = ('min/max scaler', MaxAbsScaler())

model_pipeline = Pipeline([features_pipeline, scaler, classifier])

# Model methods TODO: Wrap in flask
def train():
    model_pipeline.fit(x_train, y_train)

def save_model():
    pickle_out = open("../dataset/hackforgood.model","wb+")
    pickle.dump(model_pipeline, pickle_out, protocol=pickle.HIGHEST_PROTOCOL)
    pickle_out.close()

def load_model():
    # <3 https://www.cnblogs.com/zz22--/p/9454234.html
    #features_pipeline[1].fit_transform(features)
    #ada_classifier = pickle.load(open( "../dataset/hackforgood.model", "rb"))
    #model_pipeline = Pipeline([features_pipeline, ("AB", ada_classifier)])
    pass

def classification_report_with_accuracy_score(y_true, y_pred):
    print(classification_report(y_true, y_pred)) # print classification report
    return accuracy_score(y_true, y_pred) # return accuracy score

# TODO: Needs average scores
def validate():
    cross_val = StratifiedKFold(n_splits=10, shuffle=False, random_state=RANDOM_STATE)
    scores = cross_val_score(model_pipeline, x_train, y_train, cv=cross_val, scoring=make_scorer(classification_report_with_accuracy_score))
    print(scores)

def predict(text):
    return model_pipeline.predict([text])

# Flask API
@app.route('/predict', methods = ['POST'])
def api_predict():
    if request.method == 'POST':
        text = request.args.get('text')
        predict_class = predict(text)
        return str(predict_class)

def run_flask_api():
    app.run()

def main():
    # Parse arguments
    arguments = docopt(__doc__, version='Translaters without borders impact classifier')

    if (arguments.get("train")):
        train()
        save_model()
    elif (arguments.get("validate")):
        validate()
    elif (arguments.get("server")):
        train()
        run_flask_api()
    elif (arguments.get("predict")):
        predict_text = arguments.get("<text>")
        train()
        print(predict(predict_text))

if __name__ == "__main__":
    sys.exit(main())