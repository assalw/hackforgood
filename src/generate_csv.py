import xml.etree.ElementTree as ET
import os

# Dataset directory
directory = "../dataset/hackathon-for-good-2019_TWB-challenge_files"

# Generated dataset
hackforgood_dataset_csv = "filename, timestamp, wordcount, sourcelang, targetlang, sourcetext, targettext\n"

for filename in os.listdir(os.path.abspath(directory)):
    if filename.endswith(".sdlxliff"):
        file_path = os.path.join(directory, filename)

        doc_tree = ET.parse(file_path)

        # CSV collumns
        filename = ""

        timestamp = ""

        wordcount = ""

        sourcelang = ""

        targetlang = ""


        sourcetext = ""
        
        sourcetext_list = doc_tree.findall(".//{urn:oasis:names:tc:xliff:document:1.2}g")
        for i in sourcetext_list:
                if i.text is not None:
                        sourcetext = sourcetext + i.text

        targettext = ""

        print(sourcetext)
        #hackforgood_dataset_csv

        
