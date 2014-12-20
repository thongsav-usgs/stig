# 3.16 Configure Mail Transfer Agent for Local-Only Mode
#
# Mail Transfer Agents (MTA), such as sendmail and Postfix,
# are used to listen for incoming mail and transfer the messages
# to the appropriate user or mail server. If the system is
# not intended to be a mail server, it is recommended that
# the MTA be configured to only process local mail. By
# default, the MTA is set to loopback mode on RHEL5 and RHEL6.
#
# The software for all Mail Transfer Agents is complex and
# most have a long history of security issues. While it is
# important to ensure that the system can process local mail
# messages, it is not necessary to have the MTA’s daemon
# listening on a port unless the server is intended to be
# a mail server that receives and processes mail from other systems

template "/etc/postfix/main.cf" do
  source "main.cf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, "service[postfix]", :immediately
end

service "postfix" do
  action :nothing
end