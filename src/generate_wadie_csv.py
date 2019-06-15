import xml.etree.ElementTree as ET
import os
import re

# Used for sample dataset
#exit_please = 0

# Dataset directory
directory = "../dataset/hackathon-for-good-2019_TWB-challenge_files"

# Generated dataset
hackforgood_dataset_csv = "filename, datatype, sourcelang, targetlang, sourcetext, targettext\n"

# Loop through al the dirs
for filename in os.listdir(os.path.abspath(directory)):
    if filename.endswith(".sdlxliff"):
        
        # Get file and parse XML
        file_path = os.path.join(directory, filename)
        doc_tree = ET.parse(file_path)

        # Get the source and target languages
        file_nodes = doc_tree.findall(".//{urn:oasis:names:tc:xliff:document:1.2}file")
        
        if len(file_nodes) > 0: 
                sourcelang = file_nodes[0].attrib.get('source-language')
                targetlang = file_nodes[0].attrib.get('target-language')
                doctype = file_nodes[0].attrib.get('datatype')
        else:
             sourcelang = "NULL"
             targetlang = "NULL"

        # Get the source text
        sourcetext = ""
        sourcetext_list = doc_tree.findall(".//{urn:oasis:names:tc:xliff:document:1.2}source")

        for elem in sourcetext_list:
                for elem in elem.iter():
                        if elem.text is not None: 
                                sourcetext += " " + elem.text
        
        # Get the target text
        targettext = ""
        targettext_list = doc_tree.findall(".//{urn:oasis:names:tc:xliff:document:1.2}target")

        for elem in targettext_list:
                for elem in elem.iter():
                        if elem.text is not None: 
                                targettext += " " + elem.text

        hackforgood_dataset_csv += "\"{}\", {}, {}, {}, \"{}\", \"{}\"\n".format(filename,
                                                                                doctype,
                                                                                sourcelang, 
                                                                                targetlang, 
                                                                                sourcetext.replace('\n', ' '), 
                                                                                targettext.replace('\n', ' ')) 
        
        #Only generate a sample dataset
        #exit_please += 1
        # if exit_please > 500:
        #        hackforgood_dataset_csv_file = open("../dataset/hackforgood_dataset.csv", "w")
        #        hackforgood_dataset_csv_file.write(hackforgood_dataset_csv)
        #        hackforgood_dataset_csv_file.close()
        #        exit()

# Generate dataset
hackforgood_dataset_csv_file = open("../dataset/hackforgood_dataset_wadie.csv", "w")
hackforgood_dataset_csv_file.write(hackforgood_dataset_csv)
hackforgood_dataset_csv_file.close()