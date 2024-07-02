{ pkgs, lib, ... }:

{
  # secu
  #-------------
  # profile hardened.nix use scudo, it can breaks some programs...
  environment.memoryAllocator.provider = "libc";
  # enable hyperthreading
  security.allowSimultaneousMultithreading = lib.mkForce true;
  # disable root password
  users.users.root.hashedPassword = "!";
  # TODO set to false on day...
  users.mutableUsers = true;

  security.auditd.enable = false;
  services.sysstat.enable = false;
  systemd.coredump.enable = false;

  # casse podman non-root, mais plus secure
  security.unprivilegedUsernsClone = false;

  # speed up poweroff
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=15
  '';

  environment.etc."login.defs".source = lib.mkForce (pkgs.writeText "login.defs" ''
    DEFAULT_HOME yes

    SYS_UID_MIN  400
    SYS_UID_MAX  999
    UID_MIN      1000
    UID_MAX      29999

    SYS_GID_MIN  400
    SYS_GID_MAX  999
    GID_MIN      1000
    GID_MAX      29999

    TTYGROUP     tty
    TTYPERM      0620

    # Ensure privacy for newly created home directories.
    UMASK        077

    # Uncomment this and install chfn SUID to allow non-root
    # users to change their account GECOS information.
    # This should be made configurable.
    #CHFN_RESTRICT frwh

    # The default crypt() method, keep in sync with the PAM default
    #ENCRYPT_METHOD YESCRYPT

    ENCRYPT_METHOD SHA512
    SHA_CRYPT_MIN_ROUNDS 10000
    SHA_CRYPT_MAX_ROUNDS 50000
    PASS_MAX_DAYS   700
    PASS_MIN_DAYS   1
    PASS_WARN_AGE   300
  '');

  # add umask 027
  environment.etc."profile.local".source = lib.mkForce (pkgs.writeText "profile" ''
    umask 027
  '');

}
