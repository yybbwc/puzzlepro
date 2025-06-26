local d = {}

d.unfold = function(o1)
  local k1 = string.gsub(o1, "%.in$", "")
  return o1 .. " > " .. k1
end

do
  local k1 = [[perl "-I." "-Iutil/perl" "-Mconfigdata" "-MOpenSSL::paramnames" "util/dofile.pl" "-oMakefile" ]]
  d[#d + 1] = k1 .. d.unfold([[crypto/params_idx.c.in]])
  d[#d + 1] = k1 .. d.unfold([[include/openssl/core_names.h.in]])
  d[#d + 1] = k1 .. d.unfold([[include/internal/param_names.h.in]])
end
do
  local k1 = [[perl "-I." "-Mconfigdata" "util/dofile.pl" "-oMakefile" ]]
  d[#d + 1] = k1 .. d.unfold([[include/crypto/bn_conf.h.in]])
  d[#d + 1] = k1 .. d.unfold([[include/crypto/dso_conf.h.in]])
  d[#d + 1] = k1 .. d.unfold([[include/openssl/asn1.h.in]])
  d[#d + 1] = k1 .. d.unfold([[include/openssl/asn1t.h.in]])
  d[#d + 1] = k1 .. d.unfold([[include/openssl/bio.h.in]])
  d[#d + 1] = k1 .. d.unfold([[include/openssl/cmp.h.in]])
  d[#d + 1] = k1 .. d.unfold([[include/openssl/cms.h.in]])
  d[#d + 1] = k1 .. d.unfold([[include/openssl/comp.h.in]])
  d[#d + 1] = k1 .. d.unfold([[include/openssl/conf.h.in]])
  d[#d + 1] = k1 .. d.unfold([[include/openssl/crmf.h.in]])
  d[#d + 1] = k1 .. d.unfold([[include/openssl/crypto.h.in]])
  d[#d + 1] = k1 .. d.unfold([[include/openssl/ct.h.in]])
  d[#d + 1] = k1 .. d.unfold([[include/openssl/err.h.in]])
  d[#d + 1] = k1 .. d.unfold([[include/openssl/ess.h.in]])
  d[#d + 1] = k1 .. d.unfold([[include/openssl/fipskey.h.in]])
  d[#d + 1] = k1 .. d.unfold([[include/openssl/lhash.h.in]])
  d[#d + 1] = k1 .. d.unfold([[include/openssl/ocsp.h.in]])
  d[#d + 1] = k1 .. d.unfold([[include/openssl/opensslv.h.in]])
  d[#d + 1] = k1 .. d.unfold([[include/openssl/pkcs12.h.in]])
  d[#d + 1] = k1 .. d.unfold([[include/openssl/pkcs7.h.in]])
  d[#d + 1] = k1 .. d.unfold([[include/openssl/safestack.h.in]])
  d[#d + 1] = k1 .. d.unfold([[include/openssl/srp.h.in]])
  d[#d + 1] = k1 .. d.unfold([[include/openssl/ssl.h.in]])
  d[#d + 1] = k1 .. d.unfold([[include/openssl/ui.h.in]])
  d[#d + 1] = k1 .. d.unfold([[include/openssl/x509.h.in]])
  d[#d + 1] = k1 .. d.unfold([[include/openssl/x509_acert.h.in]])
  d[#d + 1] = k1 .. d.unfold([[include/openssl/x509_vfy.h.in]])
  d[#d + 1] = k1 .. d.unfold([[include/openssl/x509v3.h.in]])
end
do
  local k1 = [[perl "-I." "-Iproviders/common/der" "-Mconfigdata" "-Mconfigdata" "-Mconfigdata" "-Moids_to_c" "util/dofile.pl" "-oMakefile" ]]
  d[#d + 1] = k1 .. d.unfold([[providers/common/include/prov/der_digests.h.in]])
  d[#d + 1] = k1 .. d.unfold([[providers/common/include/prov/der_rsa.h.in]])
  d[#d + 1] = k1 .. d.unfold([[providers/common/include/prov/der_sm2.h.in]])
  d[#d + 1] = k1 .. d.unfold([[providers/common/include/prov/der_ec.h.in]])
  d[#d + 1] = k1 .. d.unfold([[providers/common/include/prov/der_wrap.h.in]])
  d[#d + 1] = k1 .. d.unfold([[providers/common/include/prov/der_dsa.h.in]])
  d[#d + 1] = k1 .. d.unfold([[providers/common/include/prov/der_ecx.h.in]])
  d[#d + 1] = k1 .. d.unfold([[providers/common/include/prov/der_ml_dsa.h.in]])
  d[#d + 1] = k1 .. d.unfold([[providers/common/include/prov/der_slh_dsa.h.in]])
  d[#d + 1] = k1 .. d.unfold([[providers/common/der/der_sm2_gen.c.in]])
  d[#d + 1] = k1 .. d.unfold([[providers/common/der/der_dsa_gen.c.in]])
  d[#d + 1] = k1 .. d.unfold([[providers/common/der/der_ec_gen.c.in]])
  d[#d + 1] = k1 .. d.unfold([[providers/common/der/der_ecx_gen.c.in]])
  d[#d + 1] = k1 .. d.unfold([[providers/common/der/der_ml_dsa_gen.c.in]])
  d[#d + 1] = k1 .. d.unfold([[providers/common/der/der_rsa_gen.c.in]])
  d[#d + 1] = k1 .. d.unfold([[providers/common/der/der_slh_dsa_gen.c.in]])
  d[#d + 1] = k1 .. d.unfold([[providers/common/der/der_wrap_gen.c.in]])
  d[#d + 1] = k1 .. d.unfold([[providers/common/der/der_digests_gen.c.in]])
end
do
  local k1 = [[perl util/mkbuildinf.pl "hello" "mingw64" > ]]
  d[#d + 1] = k1 .. [[crypto/buildinf.h]]
end
do
  local k1 = [[perl apps/progs.pl ]]
  d[#d + 1] = k1 .. [["-C" "apps/openssl" > apps/progs.c]]
  d[#d + 1] = k1 .. [["-H" "apps/openssl" > apps/progs.h]]
end
do
  local k1 = [[perl util/mkrc.pl ]]
  d[#d + 1] = k1 .. [[libcrypto > libcrypto.rc]]
end
for i = 1, #d do
  print(d[i])
  os.execute(d[i])
end
