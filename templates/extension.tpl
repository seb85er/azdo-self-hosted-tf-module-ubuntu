sudo mkdir /myagent 
cd /myagent
sudo wget https://vstsagentpackage.azureedge.net/agent/${script_version}/vsts-agent-linux-x64-${script_version}.tar.gz
sudo tar zxvf ./vsts-agent-linux-x64-${script_version}.tar.gz
sudo chmod -R 777 /myagent
runuser -l ${script_vm_user} -c '/myagent/config.sh --unattended  --url https://dev.azure.com/${script_azdo_org} --auth pat --token ${script_pat_token} --pool ${script_agent_pool}'
sudo /myagent/svc.sh install
sudo /myagent/svc.sh start
exit 0