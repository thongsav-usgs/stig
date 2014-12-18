default['stig']['grub']['password'] = 'ChangeMe'
md5hash = `openssl passwd -1 #{node.default['stig']['grub']['password']}`
default['stig']['grub']['hashedpassword'] = md5hash