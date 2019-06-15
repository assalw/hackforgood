from lxml import etree
import os

# Dataset directory
directory = "../dataset/hackathon-for-good-2019_TWB-challenge_files"

# Generated dataset
hackforgood_dataset_csv = "filename, timestamp, wordcount, sourcelang, targetlang, sourcetext, targettext\n"

for filename in os.listdir(os.path.abspath(directory)):
    if filename.endswith(".sdlxliff"):
        file_path = os.path.join(directory, filename)

        doc_tree = etree.parse(file_path, etree.XMLParser(huge_tree=True))

        # CSV collumns
        filename = ""

        timestamp = ""

        wordcount = ""

        sourcelang = ""

        targetlang = ""

        sourcetext = doc_tree.xpath("//*[name()='source']")

        targettext = ""

        print(sourcetext[0].values)
        #hackforgood_dataset_csv
        exit()

        
