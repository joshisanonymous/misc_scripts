import re
import requests
from bs4 import BeautifulSoup
import csv

# Variables
webSite = "https://linguistics.uga.edu"
peopleDirectory = "/directory/graduate-students"
baseUrl = "/directory/people/"

# Derived variables
directoryCode = requests.get(webSite + peopleDirectory)
directoryHtml = BeautifulSoup(directoryCode.text, "html.parser")
studentEmails = []
# slackMembers = # get the emails from the current workspace members

# Get all URLs that are for student pages
for link in directoryHtml.find_all("a"):
    url = link.get("href")
    if url.startswith(baseUrl):
        # print(url)
        studentCode = requests.get(webSite + url)
        studentHtml = BeautifulSoup(studentCode.text, "html.parser")
        for linkStudent in studentHtml.find_all("a"):
            urlStudent = linkStudent.get("href")
            if urlStudent.startswith("mailto:") and not urlStudent.endswith("linguistics@uga.edu"):
                studentEmails.append(urlStudent.strip("mailto:"))
                break

# Save emails to a csv
with open("student_emails.csv", "w") as file:
    file = csv.writer(file)
    file.writerow(studentEmails)
