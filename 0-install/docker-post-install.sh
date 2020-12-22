# If you plan to manage docker as non-root user
sudo groupadd docker
sudo usermod -aG docker $USER
# logout from the machine so group changes take effect