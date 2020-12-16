#!/bin/bash

# Запускаем замер по времени на команду ionice с флагом direct, т.е. прямая запись на диск (запускается 2 команды одновременно)
time ionice -c1 -n0 su -c "dd if=/dev/zero of=/tmp/test.img bs=512 count=1M oflag=direct" & time ionice -c2 -n7 su -c "dd if=/dev/zero of=/tmp/test2.img bs=512 count=1M oflag=direct" &


# Запускаем замер по времени на команду ionice без флага direct (запускается 2 команды одновременно)
time ionice -c1 -n0 su -c "dd if=/dev/zero of=/tmp/test.img bs=512 count=1M" & time ionice -c2 -n7 su -c "dd if=/dev/zero of=/tmp/test2.img bs=512 count=1M" &

#Также чтобы выключить I/O caching на уровне ОС, необходимо изменить значение vm.drop_caches = 0 (sysctl -a | grep vm.drop) с 0 на 3. Тогда не обязательно включать опцию прямой записи на диск.