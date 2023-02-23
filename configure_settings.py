# ----------------------------------------------
# author:  Adge Denkers / adge.denkers@gmail.com
# updated: 2023-01-06
# ----------------------------------------------
import sys

for i in range(1, len(sys.argv)):
    ip = sys.argv[i]

search_text = "ALLOWED_HOSTS = []"
replace_text = "ALLOWED_HOSTS = ['{}']".format(ip)

with open(r'/home/ubuntu/projects/www/django_app/settings.py', 'r') as file:
    data = file.read()
    data = data.replace(search_text, replace_text)

with open(r'/home/ubuntu/projects/www/django_app/settings.py', 'w') as file:
    file.write(data)

# now replace the time zone info
search_text = "TIME_ZONE = 'UTC'"
replace_text = "TIME_ZONE = 'America/New_York'"

with open(r'/home/ubuntu/projects/www/django_app/settings.py', 'r') as file:
    data = file.read()
    data = data.replace(search_text, replace_text)

with open(r'/home/ubuntu/projects/www/django_app/settings.py', 'w') as file:
    file.write(data)

print("Settings updated")
