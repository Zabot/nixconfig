let
  keys = [
    "age1tpm1qdxnaa6lvgdmrgrzvhl9gk6pkmmf7hdwqgq20wkdypk45hj83ft27rsn7us"
    "age1yubikey1qfgvvcaj2hr90lrqlre4vf050rtzrywu6r623lsp4gctarpz2srkj6svuv7"
  ];
in
{
  "secrets/home-env.age".publicKeys = keys;
  "secrets/hotspot-env.age".publicKeys = keys;
  "secrets/fastmail.age".publicKeys = keys;
}
