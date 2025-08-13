class SecretGeneratorConstant {
  final authCodeUri =
      "https://dev-ava-be.devops.indivaragroup.com/auth-service/authentication/v1/generate-auth-code/b2b2c";
  final httpAuthCodeUri =
      "http://dev-ava-be.devops.indivaragroup.com/auth-service/authentication/v1/generate-auth-code/b2b2c";
  final authCodeGAD =
      "https://dev-bpi-ava.jatisph.com/api-gateway/auth-service/authentication/v1/generate-auth-code/b2b2c";
  // final authCodeUri = "/v1/generate-auth-code/b2b2c";
  final localAuthCodeUri =
      "http://localhost:8080/auth-service/authentication/v1/generate-auth-code/b2b2c";
  // final localAuthCodeUri = "/v1/generate-auth-code/b2b2c";

  final dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX";
  // final secretKey = "f77b25d4-1c4d-4ef3-bb63-abaebe8f6db0";
  final secretKey = "F77B25D41C4D4EF3BB63ABAEBE8F6DB0";
  final cifBank = "CIF2531015624";
  final clientId = "c04ee779-1a81-4453-83ea-fd370e9f4cc9";

  final authCodeBody = {
    "paramType": "CIF_BANK",
    "paramValue": "CIF2511063896",
    "partnerChannel": "CH_BPI"
  };
  //TODO: TAKE NOTE WHY WE NEED BRANCH ID
  // final branchId = "BE7C7C7B-5AE7-4068-86E3-4AD1D1F3B30F";

  final privateKey = '''
-----BEGIN PRIVATE KEY-----
MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCin+LWpoI7VtJo
lxUemjMayf+I3ZUpfuhwYDZWAvTAY/xhRqwSohFwfJFaearbuyUNcbBNqgbZAD49
DH87IjArX68o+MUposkGm27IdV+lgzIv3VYaRlpC/0NjhGlZq5FE0D9LWgIQrgWZ
AWerHKAW4vi2dZAAfuDiUyHGGAH7lshoX1wQ1XcPU6GXDRTpQimITU7igjNrIk9K
wWL9vzcQAj1IFjiI2HcMZoflYUzwgB3VpafVTuvXD60Too2R7I4cQoNcPW0awg/j
T87xSZ0WOsAycOgkypK7MwkNDkOgEQvl4zJxW+kWvXcotyH2rFBmvBxny286lXpK
8xI8+2qDAgMBAAECggEAB/BeF8IR5aSxe+KhaM+LAv5tVVQSLybohZEJapkVWGkN
u7SLcqW0XmMS+AzQ6mmZWvbgW9SIuFSIWd0I0VG0BLjm4Dr0M16krhpkjwurQiwp
F2hhq1P8VMX28pUgA8ZHvrcJR/vsrSuizwkEvMpfmOnbO22fF/g+Q4desoDn9iiw
5b0IDxCTPfdp1tX1gIvP5adeMzXv9g+MHS0/Rg+6IszZEywK36uzJfHFJwZyKmZ0
jyW66sIq+G5Mqye5nh38NZ13YUnNYM7akepRT5A4nMOIDbwiPmO1mlIz1uZbbQej
3iCogCkNxoyFfxRx+nt2KGHgCAueUpknwAJ5nC1D6QKBgQDeGfLPlh+Y0A5S8Ee1
kgKeumlU/LQengLAJOgoYib14fs4qFXm68tXHsHOR4j4VAR/nc/ICxgF9Kw09oeR
cI7m5hr4l52eQmFWgJxlau7LodXhjyhKFhXy+6QgGuauWY2KP0YIi0P06IQnzXBF
a3eI8zejajl3e8IBXFQQ42AeyQKBgQC7cgf5LGjhK40tXiB3b8m6kiSeNFL2eDhG
n7lhe3rK+4EXs1cPSTSn3TNy54scdT+I8VjCF+opUYyeOlNUI0WzxZG300f7lSDt
RBBMagm2qunZH71IVeOrGjcCyG16yx+mHGyRBoTCCVvA1v32Ugobn515Hey45feV
TUAtOJHo6wKBgQDbjmc70rn1hGdEkgcxdN9mLf0GaLFeOvGZJGLj2POOyhBgl/gj
SSFAREVuN8UtR1ETHtxScrUS3iaGTNcDbXO2ye4LpUXJNvGmY4k3sJfTcW5Phgdc
Ba05AI3ktvMnk5uZ+Kawt4s8Rcau2iWMWopWNajgwJeCiDLmyXDJKRzSEQKBgEG1
gbIJrWJx3/Wtb3gvCeqLXKbQ9NxN3Hx1dYkEvlD1xZVHWxeStBC8bFK1dICvYWxi
Hpk7xOxjGAZHr/pouwCAG8rzF+LLrlU+bPA8o9cTJxLkG3iGE19huzMQi8BmAFw8
zpowTM2wdietti1pKP3yAEP7B4bxps8B26N+lzetAoGBANlS6Lr3iSlxFOtz2b6k
arRFyn9vl1rZMNfxSYIOf5cD/wtkH2hilK8WIceYbm/g6mJiFCmu95J4orAOr2Fb
Dd12DiKOa5xpWwH8x/iNgC1IL+rUwAgqlWIKvQQwRZ6oHZXbZ6b017A5hBm+L32M
geQRZ8NO1HaPtN/Mhj2+Tx2E
-----END PRIVATE KEY-----
''';
}
