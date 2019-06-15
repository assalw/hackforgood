import xml.etree.ElementTree as ET
import os

# Dataset directory
directory = "../dataset/hackathon-for-good-2019_TWB-challenge_files"

# Generated dataset
hackforgood_dataset_csv = "filename, sourcelang, targetlang, sourcetext, targettext\n"

for filename in os.listdir(os.path.abspath(directory)):
    if filename.endswith(".sdlxliff"):
        file_path = os.path.join(directory, filename)

        doc_tree = ET.parse(file_path)

        # CSV collumns

        file_nodes = doc_tree.findall(".//{urn:oasis:names:tc:xliff:document:1.2}file")

        sourcelang = file_nodes[0].attrib.get('source-language')

        targetlang = file_nodes[0].attrib.get('target-language')

        sourcetext = ""
        
        sourcetext_list = doc_tree.findall(".//{urn:oasis:names:tc:xliff:document:1.2}source")
        
        #for i in sourcetext_list:
        #        if i.text is not None:
        #                sourcetext = sourcetext + i.text

        targettext = ""

        for elem in sourcetext_list:
                for elem in elem.iter():
                        print(elem.text)
        #hackforgood_dataset_csv

        
