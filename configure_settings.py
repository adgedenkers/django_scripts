search_text = "ALLOWED_HOSTS = []"
replace_text = "ALLOWED_HOSTS = ['18.215.211.25']"

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
