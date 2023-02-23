echo "This script will setup Django on Ubuntu"
echo "----------------------------------------------"
echo "author:  Adge Denkers / adge.denkers@gmail.com"
echo "updated: 2023-01-06"
echo "----------------------------------------------"
echo ""
echo "Please enter the IP address:"
read ip
#ip="18.215.211.25"

app_name=read("Please enter the name of the app (no spaces or hyphens): ")
git_repo=read("Please enter the git repository for the app (no spaces or hyphens): ")


# switch to user directory
cd ~

# update software repositories
sudo apt update

# install python3 and django
sudo apt install python3-pip python3-venv -y
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.11
sudo apt install python3-django -y

# create a projects directory
mkdir projects || echo "projects directory already exists, moving on..."

cd projects

# setup a new django project
django-admin startproject django_app

# rename the root folder of the django_app to www
mv django_app $app_name
cd $app_name

# modify the allowed hosts, adding the IP address of the server
curl -O https://raw.githubusercontent.com/adgedenkers/django_scripts/main/configure_settings.py
python configure_settings.py "$ip"

# setup and activate the python virtual environment
python -m venv venv
source venv/bin/activate

# install and setup nginx
sudo apt install nginx -y

touch django_app_nginx
echo -e "server { \nlisten 80; \nserver_name "$ip";\nlocation / {\n include proxy_params;\n proxy_pass http://localhost:8000/;\n}\n}" >> django_app_nginx
sudo mv django_app_nginx /etc/nginx/sites-available/django_app:pe

sudo chmod 644 /etc/nginx/sites-available/django_app
sudo ln -s /etc/nginx/sites-available/django-app /etc/nginx/sites-enabled

# using python, install django and gunicorn
pip install gunicorn django

# create wsgi file for django_app (django_app.wsgi)
touch django_app.wsgi

# start the nginx server
gunicorn django_app.wsgi --bind 0.0.0.0:8000 --workers 1