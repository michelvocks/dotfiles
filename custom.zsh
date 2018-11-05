export PATH="$PATH:/Users/michelvocks/work/golang/bin"
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export PATH=$PATH:/Users/michelvocks/Library/Python/3.7/bin
export GOPATH="/Users/michelvocks/work/golang"
export AWS_DEFAULT_REGION="eu-central-1"
export PKG_CONFIG_PATH="/Users/michelvocks/work/golang/instantclient_12_2"
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY="YES"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_181.jdk/Contents/Home"

# Source awslogin script
source $ZSH/custom/awslogin.sh

# Source kube script
source $ZSH/custom/kubectl_config.sh

alias ll="ls -al"
alias vim="/usr/local/bin/vim"
alias v="/usr/local/bin/vim"
alias cdgaia="cd /Users/michelvocks/work/golang/src/github.com/gaia-pipeline/gaia"
alias wrappertoken="vault token renew > /dev/null && vault token create -wrap-ttl=20m"
alias idea='function _workit(){ open -b com.jetbrains.Intellij $1; };_workit'
alias vsc='function _workit(){ open -a "Visual Studio Code" $1; };_workit'
alias vpn="sudo openconnect -v -s /etc/vpnc/schenker-vpn-script https://vpnfra.dbschenker.com"
alias golinux="GOOS=linux GOARCH=amd64 go install"
alias galaxy='ansible-galaxy install -r requirements.yml -p external'

aws-ls-ec2(){
  aws ec2 describe-instances --filters "Name=instance-state-name,Values=running" --query 'Reservations[].Instances[].[PrivateIpAddress,InstanceId,Tags[?Key==`Name`].Value[]]' --output text | grep -v None | sed '$!N;s/\n/ /'|sort -k3
}

aws-ls-ec2-x(){
	selection=`aws-ls-ec2|fzf  --cycle --preview-window 0`
	ip=`echo $selection|ruby -ne 'puts $_.split(/\s/)[0]'`
	hostname=`echo $selection|ruby -ne 'puts $_.split(/\s/)[2]'`
	username=ubuntu
	if [[ $hostname =~ dbschenkercom.*(delivery|management) ]]; then
		username=ec2-user
	fi
	ssh=$username@$ip
	ssh $ssh
}

tunnelCMS() {
        aws-ls-ec2|grep dbschenkercom|grep mana
        ip=`aws-ls-ec2|grep dbschenkercom|grep mana|grep $1|cut -f 1`
        echo $ip
        ssh -v -N  -L 41080:$ip:41080 -L 41683:$ip:41683 ec2-user@$ip
}

tunnelSPIN() {
	aws-ls-ec2|grep disspinnaker
        ip=`aws-ls-ec2|grep disspinnaker|grep $1|cut -f 1`
        echo $ip
        ssh -A -L 9000:localhost:9000 -L 8084:localhost:8084 -L 8087:localhost:8087 ubuntu@$ip
}

k8sN() {
  if [ -n "$1" ]; then
    kubectl config set-context default-context --namespace=$1
  fi
  if [ -z "$1" ]; then
    kubectl config view | grep namespace:
  fi
}

nges-ro-user-fat(){vault read database/creds/eschenker-fat-oracle}
nges-ro-user-pr(){vault read database/creds/eschenker-prod-oracle}

# Init jenv
if which jenv > /dev/null; then eval "$(jenv init -)"; fi
