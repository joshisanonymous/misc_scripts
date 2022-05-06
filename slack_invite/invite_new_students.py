import re
import requests
from bs4 import BeautifulSoup

# Variables
webSite = "https://linguistics.uga.edu"
peopleDirectory = "/directory/graduate-students"
baseUrl = "/directory/people/"

# Derived variables
directoryCode = requests.get(webSite + peopleDirectory)
directoryHtml = BeautifulSoup(directoryCode.text, "html.parser")

# Get all URLs that are for student pages
students = []
for link in directoryHtml.find_all("a"):
    url = link.get("href")
    if url.startswith(baseUrl):
        students.append(webSite + url)

students
