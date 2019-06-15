import sys, os, logging
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.pipeline import FeatureUnion
from sklearn.ensemble import AdaBoostClassifier
from sklearn.pipeline import Pipeline
from sklearn.datasets import load_files
from sklearn import metrics
from sklearn.preprocessing import MaxAbsScaler
#from sklearn.cross_validation import train_test_split
#from sklearn.cross_validation import cross_val_score

import numpy as np
import pandas as pd

# Read dataset 
input_file = "../dataset/hackforgood_dataset_wadie_model.csv"
dataset_df = pd.read_csv(input_file, header = 0)

# put the original column names in a python list
original_headers = list(dataset_df.columns.values)


# Model pipeline
features = ('features', FeatureUnion([
        ('vect_w', TfidfVectorizer(min_df=0, max_df=0.95, analyzer="word", ngram_range=(1, 2))),
        ('vect_c', TfidfVectorizer(min_df=0, max_df=0.95, analyzer="char", ngram_range=(1, 2))),
        ('vec', CountVectorizer()),
    ]))

classifier = ("AB", AdaBoostClassifier(n_estimators=250))

scaler = ('min/max scaler', MaxAbsScaler())

model_pipeline = Pipeline([features, scaler, classifier])

# Model methods TODO: Wrap in flask
def train():
    print("trained")

def save_model():
    print("saved")

def predict():
    print("predicted")

def main():
    train()

if __name__ == "__main__":
    sys.exit(main())