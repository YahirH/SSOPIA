#!/usr/bin/env ruby

require 'open3'

# Instalar el paquete audit
Open3.popen3('yum install -y audit') do |stdin, stdout, stderr, wait_thr|
  exit_status = wait_thr.value.exitstatus
  unless exit_status == 0
    puts "Error al instalar el paquete audit: #{stderr.read}"
    exit exit_status
  end
end

# Habilitar y iniciar el servicio auditd
Open3.popen3('systemctl enable auditd && systemctl start auditd') do |stdin, stdout, stderr, wait_thr|
  exit_status = wait_thr.value.exitstatus
  unless exit_status == 0
    puts "Error al habilitar e iniciar el servicio auditd: #{stderr.read}"
    exit exit_status
  end
end

puts 'El servicio auditd se ha instalado, habilitado y puesto en marcha correctamente.'
