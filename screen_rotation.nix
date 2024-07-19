# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, ... }:

{
  # screen rotation
  # see https://nixos.wiki/wiki/IIO
  # and https://support.starlabs.systems/kb/guides/starlite-fixing-rotation-on-older-kernel
  hardware.sensor.iio.enable = true;
  #-----------------------
  # need to stop iio-sensor-proxy and trigger udev, no idea why...
  # systemd.services.fixiio = {
  #   script = ''
  #     sleep 15
  #     systemd-hwdb update
  #     systemctl stop iio-sensor-proxy.service
  #     udevadm trigger -v -p DEVNAME=/dev/iio:device0
  #     systemctl start iio-sensor-proxy.service
  #   '';
  #   wantedBy = [ "graphical.target" ];
  # };
  # systemd.services.iio-sensor-proxy.wantedBy = lib.mkForce []; # does not work
  #-----------------------
  # inspired by https://support.starlabs.systems/kb/guides/starlite-fixing-rotation-on-older-kernel
  # environment.etc = {
  #   "udev/hwdb.d/21-kiox000a.hwdb"= {
  #     text = ''
  #       sensor:modalias:acpi:KIOX000A*:dmi:*:*
  #         ACCEL_MOUNT_MATRIX=1, 0, 0; 0, -1, 0; 0, 0, 1;
  #         ACCEL_LOCATION=display
  #     '';
  #   };
  # };

  # Requires reboot, and in the case of KDE Plasma 6, checking the option:
  #	General Behavior > Touch Mode > Always enabled
  services.udev.extraHwdb = ''
  sensor:modalias:acpi:KIOX000A*:dmi:*:*
    ACCEL_MOUNT_MATRIX=1, 0, 0; 0, -1, 0; 0, 0, 1;
    ACCEL_LOCATION=display
  '';

  #-----------------------
  # DEBUG STUFF
  # ----
  # https://github.com/systemd/systemd/blob/main/hwdb.d/60-sensor.hwdb
  # ----
  # P: /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-KIOX000A:00/iio:device0
  # M: iio:device0
  # R: 0
  # U: iio
  # T: iio_device
  # D: c 242:0
  # N: iio:device0
  # L: 0
  # E: DEVPATH=/devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-KIOX000A:00/iio:device0
  # E: SUBSYSTEM=iio
  # E: DEVNAME=/dev/iio:device0
  # E: DEVTYPE=iio_device
  # E: MAJOR=242
  # E: MINOR=0
  # E: USEC_INITIALIZED=3060015
  # E: PATH=/nix/store/yvaww3ph4985y2wgnarvfrxi6lihswx8-udev-path/bin:/nix/store/yvaww3ph4985y2wgnarvfrxi6lihswx8-udev-path/sbin
  # E: IIO_SENSOR_PROXY_TYPE=iio-poll-accel iio-buffer-accel
  # E: SYSTEMD_WANTS=iio-sensor-proxy.service
  # E: TAGS=:systemd:
  # E: CURRENT_TAGS=:systemd:
  # ----
  # $ udevadm info -q path /dev/iio:device0
  # /devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-KIOX000A:00/iio:device0
  # $ cat /sys/devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-KIOX000A:00/iio:device0/../modalias
  # acpi:KIOX000A:KIOX000A:
  # $ cat /sys/class/dmi/id/modalias
  # dmi:bvncoreboot:bvr24.05:bd06/06/2024:br24.5:efr24.5:svnStarLabs:pnStarLite:pvr1.0:rvnStarLabs:rnStarLite:rvr1.0:cvnStarLabs:ct32:cvr1.0:skuI5:
  # ----
  # default matrix :
  # sensor:modalias:acpi:KIOX0009*:dmi:*:svnAcer:pnAspireSW3-016:*
  # sensor:acpi:KIOX000A:KIOX000A:dmi:bvncoreboot:*:*:*:*:*:pnStarLite:*:*:rnStarLite:*:*:*:*:*:
  # ACCEL_MOUNT_MATRIX=1, 0, 0; 0, 1, 0; 1, 0, 0
  # services.udev.extraHwdb = ''
  #   sensor:modalias:acpi:KIOX000A:KIOX000A:dmi:bvncoreboot:bvr24.05:bd06/06/2024:br24.5:efr24.5:svnStarLabs:pnStarLite:pvr1.0:rvnStarLabs:rnStarLite:rvr1.0:cvnStarLabs:ct32:cvr1.0:skuI5:
  #     ACCEL_MOUNT_MATRIX=1, 0, 0; 0, -1, 0; 0, 0, 1
  # '';
  # `services.udev.extraHwdb` does nothing :(
  # services.udev.extraHwdb = ''
  # sensor:modalias:acpi:KIOX000A*:dmi:*:*
  #   ACCEL_MOUNT_MATRIX=1, 0, 0; 0, -1, 0; 0, 0, 1;
  #   ACCEL_LOCATION=display
  # '';
  # ----
  # juil. 02 21:59:34 qualinost iio-sensor-prox[2714]: Could not find trigger name associated with /sys/devices/pci0000:00/0000:00:15.0/i2c_designware.0/i2c-0/i2c-KIOX000A:00/iio:device0
  # ----
  # need to stop iio-sensor-proxy and trigger udev, no idea why...
  # systemd.services.fixiio = {
  #   script = ''
  #     sleep 15
  #     systemd-hwdb update
  #     systemctl stop iio-sensor-proxy.service
  #     udevadm trigger -v -p DEVNAME=/dev/iio:device0
  #     systemctl start iio-sensor-proxy.service
  #   '';
  #   wantedBy = [ "graphical.target" ];
  # };
  # systemd.services.iio-sensor-proxy.wantedBy = lib.mkForce []; # does not work
  #-----------------------
  # inspired by https://support.starlabs.systems/kb/guides/starlite-fixing-rotation-on-older-kernel
  #environment.etc = {
  #  "udev/hwdb.d/21-kiox000a.hwdb"= {
  #    text = ''
  #      sensor:modalias:acpi:KIOX000A*:dmi:*:*
  #        ACCEL_MOUNT_MATRIX=1, 0, 0; 0, -1, 0; 0, 0, 1;
  #        ACCEL_LOCATION=display
  #    '';
  #  };
  #};
}
