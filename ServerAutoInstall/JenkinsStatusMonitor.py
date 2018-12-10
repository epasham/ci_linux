import requests
import os
import json
import time
for i in range(1,12):
    #requestHeader = {"Content-type": "Application/json", "Accept": "text/plain"}
    #r = requests.get('http://10.10.5.26:8080/computer/10.10.7.180/api/json', headers=requestHeader)
    r = requests.get('http://10.10.5.26:8080/computer/10.10.7.180/api/json')
    aa = json.loads(r.text)
    print(aa["offline"])
    if (aa["offline"] == True):
        with open('C:\Jenkins.log', 'w') as f:
            f.write(json.dumps(aa))
        os.system("sc stop jenkinsslave-C__Jenkins")
        os.system("sc start jenkinsslave-C__Jenkins")

    time.sleep(5)
