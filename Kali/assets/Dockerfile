FROM    kalilinux/kali-rolling

RUN apt update && apt upgrade -y

# Install the required toold
RUN apt install -y  \
  curl              \
  git               \
  hydra             \
  vim               \
  wget

RUN   curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && chmod 755 msfinstall && ./msfinstall
RUN   apt-get install -y exploitdb

