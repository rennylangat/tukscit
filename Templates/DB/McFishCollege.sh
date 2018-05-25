# This script creates:-
# 	- One database 
#	- Ralated tables in the database and pre-populate them with default values
#	- Stored procedures
#	- Triggers
#	- Views
#
# Authored by:-
# Name:  Felix Otieno Okoth
# Email: felix@mansoftonline.com
# Date:  Jul 28th 2014

shopt -s -o nounset

declare -r databaseName="McFishCollege"
declare username="null"
declare password="null"
declare lclhost="null"

function ExecuteSqlCommand
{
	mysql -u"$username" -p"$password" -h"$lclhost" -e"$1"	
}

function ExecuteSqlTableCommand
{
	mysql -u"$username" -p"$password" -h"$lclhost" -D"$databaseName" -e"$1"
}

printf "... Script Started... \n"

echo " >> Provide MySql UserName. Press Enter/Retun key without a value to default to 'root' user."
echo " >> Enter MySql UserName:"
read username
	if [[ -z $username ]]; then
		echo " ** Using 'root' user. ** " 
		username="root"
	fi

echo 
echo " >> Enter MySql Password:"
read password

echo
echo " >> Provide MySql Database Server Name. Press Enter/Retun key without a value to default to 'localhost'."
echo " >> Enter MySql Database Server Name:"
read lclhost
	if [[ -z $lclhost ]]; then
		echo " ** Defaulting to 'localhost' as the server. ** " 
		lclhost="localhost"
	fi

# List databases that are there in the SQL instance
ExecuteSqlCommand "show databases"

# Deletes the database if it already exists
printf "Deleting $databaseName if it exists \n"
ExecuteSqlCommand "DROP DATABASE IF EXISTS $databaseName"

# Create the database
printf "Creating $databaseName database \n"
ExecuteSqlCommand "CREATE DATABASE IF NOT EXISTS $databaseName"

# List databases that are there in the SQL instance after create
ExecuteSqlCommand "show databases"

# 	Create LanguageTable table and the related structures
printf "Creating LanguageTable ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS LanguageTable
	(mcfish_language_lciddec INT NOT NULL,
	mcfish_language_name VARCHAR(100) NOT NULL,
	mcfish_language_lcidhex VARCHAR(5) NOT NULL,
	mcfish_language_lastmodfd DATETIME NOT NULL DEFAULT '2000-01-03 04:30:43',
	PRIMARY KEY (mcfish_language_lciddec)) ENGINE=INNODB;"

#	Create PopulateLanguageTable function 
printf "Creating PopulateLanguageTable function ... \n"
ExecuteSqlTableCommand "delimiter //
	/*  Populate LanguageTable */
	INSERT INTO LanguageTable (mcfish_language_lciddec, mcfish_language_name, mcfish_language_lcidhex)
		VALUES (1101, 'Assamese', '044d'),	
			(1093, 'Bengali (India)', '0445'),	
			(1109, 'Burmese', '0455'),		
			(1126, 'Edo', '0466'),		
			(16393, 'English (India)', '4009'),		
			(1124, 'Filipino', '0464'),		
			(11276, 'French (Cameroon)', '02c0c'),		
			(9228, 'French (Congo, DRC)', '240c'),		
			(12300, 'French (Cote d\'Ivoire)', '300c'),		
			(13324, 'French (Mali)', '340c'),		
			(14348, 'French (Morocco)', '380c'),		
			(10252, 'French (Senegal)', '280c'),		
			(7180, 'French (West Indies)', '1c0c'),		
			(1122, 'Frisian (Netherlands)', '0462'),		
			(2108, 'Gaelic Ireland', '083c'),		
			(1084, 'Gaelic Scotland', '043c'),		
			(1140, 'Guarani (Paraguay)', '0474'),		
			(1279, 'HID (Human Interface Device)', '04ff'),		
			(1136, 'Igbo (Nigeria)', '0470'),		
			(1120, 'Kashmiri', '0460'),		
			(1107, 'Khmer', '0453'),		
			(1108, 'Lao', '0454'),		
			(1142, 'Latin', '0476'),		
			(1100, 'Malayalam', '044c'),		
			(1082, 'Maltese', '043a'),		
			(1112, 'Manipuri', '0458'),		
			(1153, 'Maori (New Zealand)', '0481'),		
			(1121, 'Nepali', '0461'),		
			(1096, 'Oriya', '0448'),		
			(1047, 'Rhaeto-Romanic', '0417'),		
			(2072, 'Romanian (Moldova)', '0818'),		
			(2073, 'Russian (Moldova)', '0819'),		
			(1083, 'Sami Lappish', '043b'),		
			(1072, 'Sesotho', '0430'),		
			(1113, 'Sindhi', '0459'),		
			(1115, 'Sinhalese (Sri Lanka)', '045b'),		
			(1143, 'Somali', '0477'),		
			(1070, 'Sorbian', '042a'),		
			/*(1072, 'Sutu', '0430'),*/		
			(1064, 'Tajik', '0428'),		
			(1105, 'Tibetan', '0451'),		
			(1073, 'Tsonga', '0431'),		
			(1074, 'Tswana', '0432'),		
			(1090, 'Turkmen', '0442'),		
			(1075, 'Venda', '0433'),		
			(1106, 'Welsh', '0452'),		
			(1076, 'Xhosa', '0434'),		
			(1085, 'Yiddish', '043d'),		
			(1077, 'Zulu', '0435'),		
			(1052, 'Albanian', '041c'),
			(14337, 'Arabic (U.A.E.)', '3801'),
			(11274, 'Spanish (Argentina)', '2c0a'),
			(1067, 'Armenian', '042b'),
			(3081, 'English (Australia)', '0c09'),
			(3079, 'German (Austria)', '0c07'),
			(2092, 'Azeri (Cyrillic)', '082c'),
			(1068, 'Azeri (Latin)', '042c'),
			(2067, 'Dutch (Belgium)', '0813'),
			(2060, 'French (Belgium)', '080c'),
			(2117, 'Bengali (Bangladesh)', '0845'),
			(1026, 'Bulgarian', '0402'),
			(15361, 'Arabic (Bahrain)', '3c01'),
			(5146, 'Bosnian (Bosnia/Herzegovina)', '141A'),
			(4122, 'Croatian (Bosnia/Herzegovina)', '101a'),
			(1059, 'Belarusian', '0423'),
			(10249, 'English (Belize)', '2809'),
			(16394, 'Spanish (Bolivia)', '400a'),
			(1046, 'Portuguese (Brazil)', '0416'),
			(2110, 'Malay (Brunei Darussalam)', '083e'),
			(4105, 'English (Canada)', '1009'),
			(3084, 'French (Canada)', '0c0c'),
			(9225, 'English (Caribbean)', '2409'),
			(4108, 'French (Switzerland)', '100c'),
			(2055, 'German (Switzerland)', '0807'),
			(2064, 'Italian (Switzerland)', '0810'),
			(13322, 'Spanish (Chile)', '340a'),
			(2052, 'Chinese (PRC)', '0804'),
			(9226, 'Spanish (Colombia)', '240a'),
			(5130, 'Spanish (Costa Rica)', '140a'),
			(1029, 'Czech', '0405'),
			(1031, 'German (Germany)', '0407'),
			(1030, 'Danish', '0406'),
			(7178, 'Spanish (Dominican Republic)', '1c0a'),
			(5121, 'Arabic (Algeria)', '1401'),
			(12298, 'Spanish (Ecuador)', '300a'),
			(3073, 'Arabic (Egypt)', '0c01'),
			(1069, 'Basque', '042d'),
			(1027, 'Catalan', '0403'),
			(1110, 'Galician', '0456'),
			(3082, 'Spanish (International Sort)', '0c0a'),
			(1034, 'Spanish (Traditional Sort)', '040a'),
			(1061, 'Estonian', '0425'),
			(1118, 'Amharic (Ethiopia)', '045e'),
			(1035, 'Finnish', '040b'),
			(2077, 'Swedish (Finland)', '081d'),
			(1036, 'French (France)', '040c'),
			(1080, 'Faroese', '0438'),
			(2057, 'English (United Kingdom)', '0809'),
			(1079, 'Georgian', '0437'),
			(1032, 'Greek', '0408'),
			(4106, 'Spanish (Guatemala)', '100a'),
			(3076, 'Chinese (Hong Kong S.A.R.)', '0c04'),
			(18442, 'Spanish (Honduras)', '480a'),
			(1050, 'Croatian', '041a'),
			(1038, 'Hungarian', '040e'),
			(1057, 'Indonesian', '0421'),
			(1095, 'Gujarati', '0447'),
			(1081, 'Hindi', '0439'),
			(1099, 'Kannada', '044b'),
			(1111, 'Konkani', '0457'),
			(1102, 'Marathi', '044e'),
			(1094, 'Punjabi', '0446'),
			(1103, 'Sanskrit', '044f'),
			(1097, 'Tamil', '0449'),
			(1098, 'Telugu', '044a'),
			(6153, 'English (Ireland)', '1809'),
			(1065, 'Farsi', '0429'),
			(2049, 'Arabic (Iraq)', '0801'),
			(1039, 'Icelandic', '040f'),
			(1037, 'Hebrew', '040d'),
			(1040, 'Italian (Italy)', '0410'),
			(8201, 'English (Jamaica)', '2009'),
			(11265, 'Arabic (Jordan)', '2c01'),
			(1041, 'Japanese', '0411'),
			(1087, 'Kazakh', '043f'),
			(1089, 'Swahili', '0441'),
			(1088, 'Kyrgyz (Cyrillic)', '0440'),
			(1042, 'Korean', '0412'),
			(13313, 'Arabic (Kuwait)', '3401'),
			(12289, 'Arabic (Lebanon)', '3001'),
			(4097, 'Arabic (Libya)', '1001'),
			(5127, 'German (Liechtenstein)', '1407'),
			(1063, 'Lithuanian', '0427'),
			(5132, 'French (Luxembourg)', '140c'),
			(4103, 'German (Luxembourg)', '1007'),
			(1062, 'Latvian', '0426'),
			(6145, 'Arabic (Morocco)', '1801'),
			(5124, 'Chinese (Macau S.A.R.)', '1404'),
			(6156, 'French (Monaco)', '180c'),
			(1125, 'Divehi', '0465'),
			(2058, 'Spanish (Mexico)', '080a'),
			(1071, 'FYRO Macedonian', '042f'),
			(1104, 'Mongolian (Cyrillic)', '0450'),
			(2128, 'Mongolian (Mongolia)', '0850'),
			(1086, 'Malay (Malaysia)', '043e'),
			(19466, 'Spanish (Nicaragua)', '4c0a'),
			(1043, 'Dutch (Netherlands)', '0413'),
			(1044, 'Norwegian (Bokmal)', '0414'),
			(2068, 'Norwegian (Nynorsk)', '0814'),
			(5129, 'English (New Zealand)', '1409'),
			(8193, 'Arabic (Oman)', '2001'),
			(1056, 'Urdu', '0420'),
			(6154, 'Spanish (Panama)', '180a'),
			(10250, 'Spanish (Peru)', '280a'),
			(13321, 'English (Philippines)', '3409'),
			(1045, 'Polish', '0415'),
			(20490, 'Spanish (Puerto Rico)', '500a'),
			(2070, 'Portuguese (Portugal)', '0816'),
			(15370, 'Spanish (Paraguay)', '3c0a'),
			(16385, 'Arabic (Qatar)', '4001'),
			(1048, 'Romanian', '0418'),
			(1049, 'Russian', '0419'),
			(1092, 'Tatar', '0444'),
			(1025, 'Arabic (Saudi Arabia)', '0401'),
			(4100, 'Chinese (Singapore)', '1004'),
			(17418, 'Spanish (El Salvador)', '440a'),
			(3098, 'Serbian (Cyrillic)', '0c1a'),
			(2074, 'Serbian (Latin)', '081a'),
			(1051, 'Slovak', '041b'),
			(1060, 'Slovenian', '0424'),
			(1053, 'Swedish', '041d'),
			(10241, 'Arabic (Syria)', '2801'),
			(1114, 'Syriac', '045a'),
			(1054, 'Thai', '041e'),
			(11273, 'English (Trinidad)', '2c09'),
			(7169, 'Arabic (Tunisia)', '1c01'),
			(1055, 'Turkish', '041f'),
			(1028, 'Chinese (Taiwan)', '0404'),
			(1058, 'Ukrainian', '0422'),
			(14346, 'Spanish (Uruguay)', '380a'),
			(1033, 'English (United States)', '0409'),
			(2115, 'Uzbek (Cyrillic)', '0843'),
			(1091, 'Uzbek (Latin)', '0443'),
			(8202, 'Spanish (Venezuela)', '200a'),
			(1066, 'Vietnamese', '042a'),
			(9217, 'Arabic (Yemen)', '2401'),
			(1078, 'Afrikaans', '0436'),
			(7177, 'English (South Africa)', '1c09'),
			(12297, 'English (Zimbabwe)', '3009');
	//"

# 	Create CountryTable table and the related structures
printf "Creating CountryTable ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS CountryTable
	(mcfish_country_code VARCHAR(4) NOT NULL,
	mcfish_country_desc VARCHAR(200) NOT NULL,
	mcfish_country_lastmodfd DATETIME NOT NULL DEFAULT '2000-01-03 04:30:43',
	PRIMARY KEY (mcfish_country_code),
	UNIQUE(mcfish_country_desc)) ENGINE=INNODB;"

#	Create PopulateCountryTable function 
printf "Creating PopulateCountryTable function ... \n"
ExecuteSqlTableCommand "delimiter //
	/* Populate CountryTable */
	INSERT INTO CountryTable (mcfish_country_code, mcfish_country_desc)
		VALUES ('AFG', 'AFGHANISTAN'),
			('ALB', 'ALBANIA'),
			('DZA', 'ALGERIA'),
			('ASM', 'AMERICAN SAMOA'),
			('AND', 'ANDORRA'),
			('AGO', 'ANGOLA'),
			('AIA', 'ANGUILLA'),
			('ATA', 'ANTARCTICA'),
			('ATG', 'ANTIGUA AND BARBUDA'),
			('ARG', 'ARGENTINA'),
			('ARM', 'ARMENIA'),
			('ABW', 'ARUBA'),
			('AUS', 'AUSTRALIA'),
			('AUT', 'AUSTRIA'),
			('AZE', 'AZERBAIJAN'),
			('BHS', 'BAHAMAS'),
			('BHR', 'BAHRAIN'),
			('BGD', 'BANGLADESH'),
			('BRB', 'BARBADOS'),
			('BLR', 'BELARUS'),
			('BEL', 'BELGIUM'),
			('BLZ', 'BELIZE'),
			('BEN', 'BENIN'),
			('BMU', 'BERMUDA'),
			('BTN', 'BHUTAN'),
			('BOL', 'BOLIVIA'),
			('BIH', 'BOSNIA AND HERZEGOWINA'),
			('BWA', 'BOTSWANA'),
			('BVT', 'BOUVET ISLAND'),
			('BRA', 'BRAZIL'),
			('IOT', 'BRITISH INDIAN OCEAN TERRITORY'),
			('BRN', 'BRUNEI DARUSSALAM'),
			('BGR', 'BULGARIA'),
			('BFA', 'BURKINA FASO'),
			('BDI', 'BURUNDI'),
			('KHM', 'CAMBODIA'),
			('CMR', 'CAMEROON'),
			('CAN', 'CANADA'),
			('CPV', 'CAPE VERDE'),
			('CYM', 'CAYMAN ISLANDS'),
			('CAF', 'CENTRAL AFRICAN REPUBLIC'),
			('TCD', 'CHAD'),
			('CHL', 'CHILE'),
			('CHN', 'CHINA'),
			('CXR', 'CHRISTMAS ISLAND'),
			('CCK', 'COCOS (KEELING) ISLANDS'),
			('COL', 'COLOMBIA'),
			('COM', 'COMOROS'),
			('COG', 'CONGO'),
			('COD', 'CONGO, THE DRC'),
			('COK', 'COOK ISLANDS'),
			('CRI', 'COSTA RICA'),
			('CIV', 'COTE D\'IVOIRE'),
			('HRV', 'CROATIA'),
			('CUB', 'CUBA'),
			('CYP', 'CYPRUS'),
			('CZE', 'CZECH REPUBLIC'),
			('DNK', 'DENMARK'),
			('DJI', 'DJIBOUTI'),
			('DMA', 'DOMINICA'),
			('DOM', 'DOMINICAN REPUBLIC'),
			('TMP', 'EAST TIMOR'),
			('ECU', 'ECUADOR'),
			('EGY', 'EGYPT'),
			('SLV', 'EL SALVADOR'),
			('GNQ', 'EQUATORIAL GUINEA'),
			('ERI', 'ERITREA'),
			('EST', 'ESTONIA'),
			('ETH', 'ETHIOPIA '),
			('FRO', 'FAROE ISLANDS'),
			('FJI', 'FIJI'),
			('FIN', 'FINLAND'),
			('FRA', 'FRANCE'),
			('FXX', 'FRANCE, METROPOLITAN'),
			('GUF', 'FRENCH GUIANA'),
			('PYF', 'FRENCH POLYNESIA'),
			('ATF', 'FRENCH SOUTHERN TERRITORIES'),
			('GAB', 'GABON'),
			('FLK', 'FALKLAND ISLANDS (MALVINAS)'),
			('GMB', 'GAMBIA'),
			('GEO', 'GEORGIA'),
			('DEU', 'GERMANY'),
			('GHA', 'GHANA'),
			('GIB', 'GIBRALTAR'),
			('GRC', 'GREECE'),
			('GRL', 'GREENLAND'),
			('GRD', 'GRENADA'),
			('GLP', 'GUADELOUPE'),
			('GUM', 'GUAM'),
			('GTM', 'GUATEMALA'),
			('GIN', 'GUINEA'),
			('GNB', 'GUINEA-BISSAU'),
			('GUY', 'GUYANA'),
			('HTI', 'HAITI'),
			('HMD', 'HEARD AND MC DONALD ISLANDS'),
			('VAT', 'HOLY SEE (VATICAN CITY STATE)'),
			('HND', 'HONDURAS'),
			('HKG', 'HONG KONG'),
			('HUN', 'HUNGARY'),
			('ISL', 'ICELAND'),
			('IND', 'INDIA'),
			('IDN', 'INDONESIA'),
			('IRN', 'IRAN (ISLAMIC REPUBLIC OF)'),
			('IRQ', 'IRAQ'),
			('IRL', 'IRELAND'),
			('ISR', 'ISRAEL'),
			('ITA', 'ITALY'),
			('JAM', 'JAMAICA'),
			('JPN', 'JAPAN'),
			('JOR', 'JORDAN'),
			('KAZ', 'KAZAKHSTAN'),
			('KEN', 'KENYA'),
			('KIR', 'KIRIBATI'),
			('PRK', 'KOREA, D.P.R.O.'),
			('KOR', 'KOREA, REPUBLIC OF'),
			('KWT', 'KUWAIT'),
			('KGZ', 'KYRGYZSTAN'),
			('LAO', 'LAOS'),
			('LVA', 'LATVIA'),
			('LBN', 'LEBANON'),
			('LSO', 'LESOTHO'),
			('LBR', 'LIBERIA'),
			('LBY', 'LIBYAN ARAB JAMAHIRIYA'),
			('LIE', 'LIECHTENSTEIN'),
			('LTU', 'LITHUANIA'),
			('LUX', 'LUXEMBOURG'),
			('MAC', 'MACAU'),
			('MKD', 'MACEDONIA'),
			('MDG', 'MADAGASCAR'),
			('MWI', 'MALAWI'),
			('MYS', 'MALAYSIA'),
			('MDV', 'MALDIVES'),
			('MLI', 'MALI'),
			('MLT', 'MALTA'),
			('MHL', 'MARSHALL ISLANDS'),
			('MTQ', 'MARTINIQUE'),
			('MRT', 'MAURITANIA'),
			('MUS', 'MAURITIUS'),
			('MYT', 'MAYOTTE'),
			('MEX', 'MEXICO'),
			('FSM', 'MICRONESIA, FEDERATED STATES OF'),
			('MDA', 'MOLDOVA, REPUBLIC OF'),
			('MCO', 'MONACO'),
			('MNG', 'MONGOLIA'),
			('MSR', 'MONTSERRAT'),
			('MAR', 'MOROCCO'),
			('MOZ', 'MOZAMBIQUE'),
			('MMR', 'MYANMAR (Burma)'),
			('NAM', 'NAMIBIA'),
			('NRU', 'NAURU'),
			('NPL', 'NEPAL'),
			('NLD', 'NETHERLANDS'),
			('ANT', 'NETHERLANDS ANTILLES'),
			('NCL', 'NEW CALEDONIA'),
			('NZL', 'NEW ZEALAND'),
			('NIC', 'NICARAGUA'),
			('NER', 'NIGER'),
			('NGA', 'NIGERIA'),
			('NIU', 'NIUE'),
			('NFK', 'NORFOLK ISLAND'),
			('MNP', 'NORTHERN MARIANA ISLANDS'),
			('NOR', 'NORWAY'),
			('OMN', 'OMAN'),
			('PAK', 'PAKISTAN'),
			('PLW', 'PALAU'),
			('PAN', 'PANAMA'),
			('PNG', 'PAPUA NEW GUINEA'),
			('PRY', 'PARAGUAY'),
			('PER', 'PERU'),
			('PHL', 'PHILIPPINES'),
			('PCN', 'PITCAIRN'),
			('POL', 'POLAND'),
			('PRT', 'PORTUGAL'),
			('PRI', 'PUERTO RICO'),
			('QAT', 'QATAR'),
			('REU', 'REUNION'),
			('ROM', 'ROMANIA'),
			('RUS', 'RUSSIAN FEDERATION'),
			('RWA', 'RWANDA'),
			('KNA', 'SAINT KITTS AND NEVIS'),
			('LCA', 'SAINT LUCIA'),
			('VCT', 'SAINT VINCENT AND THE GRENADINES'),
			('WSM', 'SAMOA'),
			('SMR', 'SAN MARINO'),
			('STP', 'SAO TOME AND PRINCIPE'),
			('SAU', 'SAUDI ARABIA'),
			('SEN', 'SENEGAL'),
			('SYC', 'SEYCHELLES'),
			('SLE', 'SIERRA LEONE'),
			('SGP', 'SINGAPORE'),
			('SVK', 'SLOVAKIA (Slovak Republic)'),
			('SVN', 'SLOVENIA'),
			('SLB', 'SOLOMON ISLANDS'),
			('SOM', 'SOMALIA'),
			('ZAF', 'SOUTH AFRICA'),
			('SGS', 'SOUTH GEORGIA AND SOUTH S.S.'),
			('ESP', 'SPAIN'),
			('LKA', 'SRI LANKA'),
			('SHN', 'ST. HELENA'),
			('SPM', 'ST. PIERRE AND MIQUELON'),
			('SDN', 'SUDAN'),
			('SUR', 'SURINAME'),
			('SJM', 'SVALBARD AND JAN MAYEN ISLANDS'),
			('SWZ', 'SWAZILAND'),
			('SWE', 'SWEDEN'),
			('CHE', 'SWITZERLAND'),
			('SYR', 'SYRIAN ARAB REPUBLIC'),
			('TWN', 'TAIWAN, PROVINCE OF CHINA'),
			('TJK', 'TAJIKISTAN'),
			('TZA', 'TANZANIA, UNITED REPUBLIC OF'),
			('THA', 'THAILAND'),
			('TGO', 'TOGO'),
			('TKL', 'TOKELAU'),
			('TON', 'TONGA'),
			('TTO', 'TRINIDAD AND TOBAGO'),
			('TUN', 'TUNISIA'),
			('TUR', 'TURKEY'),
			('TKM', 'TURKMENISTAN'),
			('TCA', 'TURKS AND CAICOS ISLANDS'),
			('TUV', 'TUVALU'),
			('UGA', 'UGANDA'),
			('UKR', 'UKRAINE'),
			('ARE', 'UNITED ARAB EMIRATES'),
			('GBR', 'UNITED KINGDOM'),
			('USA', 'UNITED STATES'),
			('UMI', 'U.S. MINOR ISLANDS'),
			('URY', 'URUGUAY'),
			('UZB', 'UZBEKISTAN'),
			('VUT', 'VANUATU'),
			('VEN', 'VENEZUELA'),
			('VNM', 'VIET NAM'),
			('VGB', 'VIRGIN ISLANDS (BRITISH)'),
			('VIR', 'VIRGIN ISLANDS (U.S.)'),
			('WLF', 'WALLIS AND FUTUNA ISLANDS'),
			('ESH', 'WESTERN SAHARA'),
			('YEM', 'YEMEN'),
			('YUG', 'Yugoslavia (Serbia and Montenegro)'),
			('ZMB', 'ZAMBIA'),
			('ZWE', 'ZIMBABWE');
	//"

# 	Create Tenant table and the related structures
printf "Creating TenantTable ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS TenantTable 
	(mcfish_tenant_uuid CHAR(36) NOT NULL,
	mcfish_tenant_tenant CHAR(36) NOT NULL,
	mcfish_tenant_head CHAR(36),
	mcfish_tenant_parent CHAR(36),
	mcfish_tenant_description VARCHAR(200) NOT NULL,
	mcfish_tenant_language INT NOT NULL,
	mcfish_tenant_country VARCHAR(4) NOT NULL,
	mcfish_tenant_photo BLOB,
	mcfish_tenant_finyr DATETIME,
	mcfish_tenant_enabled TINYINT(1) NOT NULL,
	mcfish_tenant_lastmodfd DATETIME NOT NULL DEFAULT '2000-01-03 04:30:43',
	PRIMARY KEY (mcfish_tenant_uuid),
	UNIQUE(mcfish_tenant_parent, mcfish_tenant_description),
	FOREIGN KEY(mcfish_tenant_language) 
		REFERENCES LanguageTable(mcfish_language_lciddec) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY(mcfish_tenant_country) 
		REFERENCES CountryTable(mcfish_country_code) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

#	Create UserAuth table and the related structures
printf "Creating UserAuth ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS UserAuth 
	(mcfish_uath_username CHAR(20) NOT NULL,
	mcfish_uath_userid CHAR(36) NOT NULL,
	mcfish_uath_pwd LONGBLOB NOT NULL,
	mcfish_uath_salt LONGBLOB NOT NULL,
	mcfish_uath_cdate DATE NOT NULL,
	mcfish_uath_email VARCHAR(100) NOT NULL,
	mcfish_uath_llogin DATE,
	mcfish_uath_lloginloc VARCHAR(20),
	mcfish_uath_faillogin INT,
	mcfish_uath_lock TINYINT(1),
	PRIMARY KEY (mcfish_uath_userid),
	UNIQUE (mcfish_uath_username)) ENGINE=INNODB;"

#	Create Member table and the related structures
printf "Creating Member ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS Member 
	(mcfish_memb_mbrid CHAR(36) NOT NULL,
	mcfish_memb_dname VARCHAR(50) NOT NULL,
	mcfish_memb_fname VARCHAR(15) NOT NULL,
	mcfish_memb_mname VARCHAR(15) NOT NULL,
	mcfish_memb_lname VARCHAR(15) NOT NULL,
	mcfish_memb_id VARCHAR(20) NOT NULL,
	mcfish_memb_module ENUM('STUDENT', 'TEACHER', 'STAFF', 'SUBORDINATE', 'PARENT', 'SUPLIER', 'ACCOUNTANT', 'PRINCIPAL', 'ALL', 'INVENTORY', 'KITCHEN', 'DSA') NOT NULL,
	mcfish_memb_tenantid CHAR(36),
	mcfish_memb_photo LONGBLOB,
	mcfish_memb_dob DATE,
	mcfish_memb_gender ENUM('MALE', 'FEMALE', 'BOTH', 'NA'),
	PRIMARY KEY (mcfish_memb_mbrid),
	UNIQUE (mcfish_memb_tenantid, mcfish_memb_id),
	FOREIGN KEY (mcfish_memb_mbrid) 
		REFERENCES UserAuth(mcfish_uath_userid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_memb_tenantid) 
		REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

#	Create MemberContact table and the related structures
printf "Creating MemberContact ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS MemberContact 
	(mcfish_membc_id INT NOT NULL AUTO_INCREMENT,
	mcfish_membc_mid CHAR(36) NOT NULL,
	mcfish_membc_name VARCHAR(50),
	mcfish_membc_postaladdr VARCHAR(500) NOT NULL,
	mcfish_membc_phyloc VARCHAR(500) NOT NULL,
	mcfish_membc_homephone VARCHAR(20),
	mcfish_membc_mobile VARCHAR(20),
	mcfish_membc_zip VARCHAR(10),
	mcfish_membc_town VARCHAR(50) NOT NULL,
	mcfish_membc_state VARCHAR(50) NOT NULL,
	mcfish_membc_country VARCHAR(4) NOT NULL,
	PRIMARY KEY (mcfish_membc_id),
	FOREIGN KEY (mcfish_membc_mid) 
		REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_membc_country) 
		REFERENCES CountryTable(mcfish_country_code) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

# 	Create SchoolSetting table and the related structures
printf "Creating SchoolSetting ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolSetting 
	(mcfish_schsetng_school CHAR(36) NOT NULL,
	mcfish_schsetng_cyear INT NOT NULL,
	mcfish_schsetng_term INT NOT NULL,
	mcfish_schsetng_pmonth INT NOT NULL,
	mcfish_schsetng_pyear INT NOT NULL,
	PRIMARY KEY (mcfish_schsetng_school),
	FOREIGN KEY (mcfish_schsetng_school)		 
			REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolLevel ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolLevel 
	(mcfish_schlvl_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schlvl_desc VARCHAR(20) NOT NULL,
	mcfish_schlvl_tenant CHAR(36) NOT NULL,
	PRIMARY KEY (mcfish_schlvl_id),
	UNIQUE (mcfish_schlvl_tenant, mcfish_schlvl_desc),
	FOREIGN KEY (mcfish_schlvl_tenant)		 
			REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolLvlSubStg ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolLvlSubStg 
	(mcfish_schlvlstg_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schlvlstg_grp ENUM('COMPULSORY', 'SCIENCE', 'HUMANITY', 'TECHNICALANDAPPLIED', 'OTHERS') NOT NULL,
	mcfish_schlvlstg_no INT NOT NULL,
	mcfish_schlvlstg_lvl INT NOT NULL,
	mcfish_schlvlstg_tenant CHAR(36) NOT NULL,
	PRIMARY KEY (mcfish_schlvlstg_id),
	UNIQUE (mcfish_schlvlstg_tenant, mcfish_schlvlstg_lvl, mcfish_schlvlstg_grp),
	FOREIGN KEY (mcfish_schlvlstg_tenant)		 
			REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schlvlstg_lvl)		 
			REFERENCES SchoolLevel(mcfish_schlvl_id) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolStudyMode ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolStudyMode 
	(mcfish_schsmode_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schsmode_desc VARCHAR(20) NOT NULL,
	mcfish_schsmode_tenant CHAR(36) NOT NULL,
	PRIMARY KEY (mcfish_schsmode_id),
	UNIQUE (mcfish_schsmode_tenant, mcfish_schsmode_desc),
	FOREIGN KEY (mcfish_schsmode_tenant)		 
			REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolClass ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolClass 
	(mcfish_schcls_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schlcls_desc VARCHAR(50) NOT NULL,
	mcfish_schcls_lvl INT NOT NULL,
	mcfish_schcls_parent INT,
	mcfish_schcls_tenant CHAR(36) NOT NULL,
	PRIMARY KEY (mcfish_schcls_id),
	UNIQUE (mcfish_schcls_tenant, mcfish_schlcls_desc),
	FOREIGN KEY (mcfish_schcls_tenant)		 
		REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schcls_lvl)		 
		REFERENCES SchoolLevel(mcfish_schlvl_id) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolFaculty ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolFaculty
	(mcfish_schfty_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schfty_tenant CHAR(36) NOT NULL,
	mcfish_schfty_desc VARCHAR(200) NOT NULL,
	PRIMARY KEY (mcfish_schfty_id),
	UNIQUE (mcfish_schfty_tenant, mcfish_schfty_desc),
	FOREIGN KEY (mcfish_schfty_tenant)		 
		REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolCourse ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolCourse
	(mcfish_schcrse_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schcrse_tenant CHAR(36) NOT NULL,
	mcfish_schcrse_desc VARCHAR(200) NOT NULL,
	mcfish_schcrse_faculty INT NOT NULL,
	PRIMARY KEY (mcfish_schcrse_id),
	UNIQUE (mcfish_schcrse_tenant, mcfish_schcrse_desc, mcfish_schcrse_faculty),
	FOREIGN KEY (mcfish_schcrse_faculty)		 
		REFERENCES SchoolFaculty(mcfish_schfty_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schcrse_tenant)
		REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

# 	Create SchoolAccount table and the related structures
printf "Creating SchoolAccount ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolAccount 
	(mcfish_schacc_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schacc_school CHAR(36) NOT NULL,
	mcfish_schacc_cdate DATE NOT NULL,
	mcfish_schacc_desc VARCHAR(100) NOT NULL,
	mcfish_schacc_acno VARCHAR(20) NOT NULL,
	PRIMARY KEY (mcfish_schacc_id),
	UNIQUE (mcfish_schacc_school, mcfish_schacc_desc),
	UNIQUE (mcfish_schacc_school, mcfish_schacc_acno),
	FOREIGN KEY (mcfish_schacc_school)		 
		REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

# 	Create SchoolAccPayMode table and the related structures
printf "Creating SchoolAccPayMode ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolAccPayMode 
	(mcfish_schaccpm_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schaccpm_school CHAR(36) NOT NULL,
	mcfish_schaccpm_acc INT NOT NULL,
	mcfish_schaccpm_pmode ENUM('CASH', 'MPESA', 'BANKSLIP', 'CHEQUE', 'MONEYORDER') NOT NULL,
	PRIMARY KEY (mcfish_schaccpm_id),
	UNIQUE (mcfish_schaccpm_school, mcfish_schaccpm_acc, mcfish_schaccpm_pmode),
	FOREIGN KEY (mcfish_schaccpm_school)		 
		REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schaccpm_acc)		 
		REFERENCES SchoolAccount(mcfish_schacc_id) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

# 	Create SchoolAccBal table and the related structures
printf "Creating SchoolAccBal ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolAccBal 
	(mcfish_schaccb_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schaccb_school CHAR(36) NOT NULL,
	mcfish_schaccb_cdate DATE NOT NULL,
	mcfish_schaccb_acc INT NOT NULL,
	mcfish_schaccb_term INT NOT NULL,
	mcfish_schaccb_year INT NOT NULL,
	mcfish_schaccb_amt FLOAT(12,2) NOT NULL, 
	PRIMARY KEY (mcfish_schaccb_id),
	UNIQUE (mcfish_schaccb_acc, mcfish_schaccb_term, mcfish_schaccb_year),
	FOREIGN KEY (mcfish_schaccb_school)		 
		REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schaccb_acc)		 
		REFERENCES SchoolAccount(mcfish_schacc_id) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolCharge ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolCharge 
	(mcfish_schcharge_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schcharge_desc VARCHAR(100) NOT NULL,
	mcfish_schcharge_acc INT NOT NULL,
	mcfish_schcharge_order INT NOT NULL,
	mcfish_schcharge_tenant CHAR(36) NOT NULL,
	PRIMARY KEY (mcfish_schcharge_id),
	UNIQUE (mcfish_schcharge_tenant, mcfish_schcharge_desc),
	FOREIGN KEY (mcfish_schcharge_tenant)		 
			REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schcharge_acc)		 
			REFERENCES SchoolAccount(mcfish_schacc_id) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolFee ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolFee 
	(mcfish_schfee_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schfee_charge INT NOT NULL,
	mcfish_schfee_course INT NOT NULL,
	mcfish_schfee_term INT NOT NULL,
	mcfish_schfee_mode INT NOT NULL,
	mcfish_schfee_amt FLOAT(12,2) NOT NULL,
	mcfish_schfee_tenant CHAR(36) NOT NULL,
	mcfish_schfee_prorate TINYINT(1) NOT NULL,
	mcfish_schfee_onetime TINYINT(1) NOT NULL,
	PRIMARY KEY (mcfish_schfee_id),
	UNIQUE (mcfish_schfee_charge, mcfish_schfee_course, mcfish_schfee_mode, mcfish_schfee_term),
	FOREIGN KEY (mcfish_schfee_tenant)		 
			REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schfee_charge)		 
			REFERENCES SchoolCharge(mcfish_schcharge_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schfee_course)		 
			REFERENCES SchoolCourse(mcfish_schcrse_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schfee_mode)		 
			REFERENCES SchoolStudyMode(mcfish_schsmode_id) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolHouse ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolHouse 
	(mcfish_schhse_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schhse_desc VARCHAR(50) NOT NULL,
	mcfish_schhse_motto VARCHAR(50),
	mcfish_schhse_master CHAR(36),
	mcfish_schhse_pref CHAR(36),
	mcfish_schhse_tenant CHAR(36) NOT NULL,
	PRIMARY KEY (mcfish_schhse_id),
	UNIQUE (mcfish_schhse_tenant, mcfish_schhse_desc),
	FOREIGN KEY (mcfish_schhse_tenant)		 
		REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schhse_master) 
		REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schhse_pref) 
		REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolDorm ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolDorm 
	(mcfish_schdorm_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schdorm_desc VARCHAR(50) NOT NULL,
	mcfish_schdorm_motto VARCHAR(50),
	mcfish_schdorm_capacity INT NOT NULL,
	mcfish_schdorm_house INT NOT NULL,
	mcfish_schdorm_master CHAR(36),
	mcfish_schdorm_pref CHAR(36),
	mcfish_schdorm_tenant CHAR(36) NOT NULL,
	PRIMARY KEY (mcfish_schdorm_id),
	UNIQUE (mcfish_schdorm_house, mcfish_schdorm_desc),
	FOREIGN KEY (mcfish_schdorm_tenant)		 
		REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schdorm_house)		 
		REFERENCES SchoolHouse(mcfish_schhse_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schdorm_master) 
		REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schdorm_pref) 
		REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolStudent ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolStudent 
	(mcfish_schstud_id CHAR(36) NOT NULL,
	mcfish_schstud_entryg ENUM('A_PLUS', 'A', 'A_MINUS', 'B_PLUS', 'B', 'B_MINUS', 'C_PLUS', 'C', 'C_MINUS', 'D_PLUS', 'D', 'D_MINUS', 'E_PLUS', 'E', 'E_MINUS', 'F_PLUS', 'F', 'F_MINUS', 'NA', 'FAIL', 'INCOMPLETE', 'PASS'),
	mcfish_schstud_entrym INT,
	mcfish_schstud_status ENUM('ACTIVE', 'SUSPENDED', 'ALUMNI', 'NA') NOT NULL,
	mcfish_schstud_religion ENUM('CATHOLIC', 'PROTESTANT', 'MUSLIM', 'OTHERS', 'NA') NOT NULL,
	mcfish_schstud_hedu ENUM('PRIMARY', 'SECONDARY', 'UNDERGRADUATE', 'GRADUATE', 'POSTGRADUATE', 'NA') NOT NULL,
	mcfish_schstud_admindte DATE NOT NULL,	
	mcfish_schstud_dorm INT,	
	mcfish_schstud_admno VARCHAR(20) NOT NULL,
	mcfish_schstud_class INT NOT NULL,
	mcfish_schstud_mode INT NOT NULL,
	mcfish_schstud_course INT NOT NULL,
	mcfish_schstud_promote TINYINT(1) NOT NULL,
	mcfish_schstud_tenant CHAR(36) NOT NULL,
	PRIMARY KEY (mcfish_schstud_id),
	UNIQUE (mcfish_schstud_tenant, mcfish_schstud_admno),
	FOREIGN KEY (mcfish_schstud_tenant)		 
		REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schstud_id)		 
		REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schstud_dorm) 
		REFERENCES SchoolDorm(mcfish_schdorm_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schstud_class) 
		REFERENCES SchoolLevel(mcfish_schlvl_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schstud_mode) 
		REFERENCES SchoolStudyMode(mcfish_schsmode_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schstud_course) 
		REFERENCES SchoolCourse(mcfish_schcrse_id) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

#	Create StudentAttachment table and the related structures
printf "Creating StudentAttachment ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS StudentAttachment 
	(mcfish_statt_id INT NOT NULL AUTO_INCREMENT,
	mcfish_statt_sid CHAR(36) NOT NULL,
	mcfish_statt_desc VARCHAR(50) NOT NULL,
	mcfish_statt_tenantid CHAR(36) NOT NULL,
	mcfish_statt_att LONGBLOB NOT NULL,
	mcfish_statt_date DATE NOT NULL,
	PRIMARY KEY (mcfish_statt_id),
	UNIQUE (mcfish_statt_sid, mcfish_statt_desc),
	FOREIGN KEY (mcfish_statt_sid) 
		REFERENCES SchoolStudent(mcfish_schstud_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_statt_tenantid) 
		REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

#	Create StudentEntExam table and the related structures
printf "Creating StudentEntExam ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS StudentEntExam 
	(mcfish_stente_id INT NOT NULL AUTO_INCREMENT,
	mcfish_stente_sid CHAR(36) NOT NULL,
	mcfish_stente_desc VARCHAR(50) NOT NULL,
	mcfish_stente_score VARCHAR(10) NOT NULL,
	mcfish_stente_comments VARCHAR(200),
	mcfish_stente_tenantid CHAR(36) NOT NULL,
	mcfish_stente_date DATE NOT NULL,
	mcfish_stente_actor CHAR(36) NOT NULL,
	PRIMARY KEY (mcfish_stente_id),
	UNIQUE (mcfish_stente_sid, mcfish_stente_desc),
	FOREIGN KEY (mcfish_stente_sid) 
		REFERENCES SchoolStudent(mcfish_schstud_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_stente_actor) 
		REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_stente_tenantid) 
		REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolStudFee ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolStudFee 
	(mcfish_schstudf_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schstudf_stud CHAR(36) NOT NULL,
	mcfish_schstudf_postdte DATE NOT NULL,
	mcfish_schstudf_fee INT NOT NULL,	
	mcfish_schstudf_term INT NOT NULL,
	mcfish_schstudf_year INT NOT NULL,
	mcfish_schstudf_amt FLOAT(12,2) NOT NULL,
	mcfish_schstudf_pamt FLOAT(12,2) NOT NULL,
	mcfish_schstudf_course INT NOT NULL,
	mcfish_schstudf_tenant CHAR(36) NOT NULL,
	PRIMARY KEY (mcfish_schstudf_id),
	UNIQUE (mcfish_schstudf_stud, mcfish_schstudf_term, mcfish_schstudf_year, mcfish_schstudf_fee),
	FOREIGN KEY (mcfish_schstudf_fee)		 
		REFERENCES SchoolFee(mcfish_schfee_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schstudf_tenant)		 
		REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schstudf_stud)		 
		REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schstudf_course) 
		REFERENCES SchoolCourse(mcfish_schcrse_id) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolStudFeePayment ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolStudFeePayment 
	(mcfish_schsfpay_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schsfpay_pmode ENUM('CASH', 'MPESA', 'BANKSLIP', 'CHEQUE', 'MONEYORDER') NOT NULL,
	mcfish_schsfpay_ref VARCHAR(20) NOT NULL,
	mcfish_schsfpay_rctno VARCHAR(20) NOT NULL,
	mcfish_schsfpay_term INT NOT NULL,
	mcfish_schsfpay_year INT NOT NULL,
	mcfish_schsfpay_amt FLOAT(12,2) NOT NULL,
	mcfish_schsfpay_stud CHAR(36) NOT NULL,
	mcfish_schsfpay_postdte DATE NOT NULL,
	mcfish_schsfpay_tenant CHAR(36) NOT NULL,
	PRIMARY KEY (mcfish_schsfpay_id),
	UNIQUE (mcfish_schsfpay_tenant, mcfish_schsfpay_rctno),
	UNIQUE (mcfish_schsfpay_tenant, mcfish_schsfpay_ref),
	FOREIGN KEY (mcfish_schsfpay_stud)		 
		REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schsfpay_tenant)		 
		REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolStudFeeHist ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolStudFeeHist 
	(mcfish_schstudfh_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schstudfh_pmode ENUM('CASH', 'MPESA', 'BANKSLIP', 'CHEQUE', 'MONEYORDER') NOT NULL,	
	mcfish_schstudfh_ref VARCHAR(20) NOT NULL,
	mcfish_schstudfh_rctno VARCHAR(20) NOT NULL,
	mcfish_schstudfh_postdte DATE NOT NULL,	
	mcfish_schstudfh_fee INT NOT NULL,
	mcfish_schstudfh_amt FLOAT(12,2) NOT NULL,
	mcfish_schstudfh_payid INT NOT NULL,
	PRIMARY KEY (mcfish_schstudfh_id),
	FOREIGN KEY (mcfish_schstudfh_fee) 
		REFERENCES SchoolStudFee(mcfish_schstudf_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schstudfh_payid) 
		REFERENCES SchoolStudFeePayment(mcfish_schsfpay_id) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolStudFeeBal ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolStudFeeBal 
	(mcfish_schstudfb_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schstudfb_postdte DATE NOT NULL,
	mcfish_schstudfb_amt FLOAT(12,2) NOT NULL,
	mcfish_schstudfb_term INT NOT NULL,
	mcfish_schstudfb_year INT NOT NULL,
	mcfish_schstudfb_payid INT NOT NULL,
	mcfish_schstudfb_stud CHAR(36) NOT NULL,
	mcfish_schstudfb_tenant CHAR(36) NOT NULL,
	PRIMARY KEY (mcfish_schstudfb_id),
	UNIQUE (mcfish_schstudfb_payid, mcfish_schstudfb_tenant),
	FOREIGN KEY (mcfish_schstudfb_payid) 
		REFERENCES SchoolStudFeePayment(mcfish_schsfpay_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schstudfb_stud)		 
		REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schstudfb_tenant)		 
		REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolPayVourcher ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolPayVourcher
	(mcfish_schvouch_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schvouch_tenant CHAR(36) NOT NULL,
	mcfish_schvouch_actor CHAR(36) NOT NULL,
	mcfish_schvouch_authrz CHAR(36),
	mcfish_schvouch_payer CHAR(36),
	mcfish_schvouch_pmode ENUM('CASH', 'MPESA', 'BANKSLIP', 'CHEQUE', 'MONEYORDER'),	
	mcfish_schvouch_ref VARCHAR(20),
	mcfish_schvouch_lpono VARCHAR(20),
	mcfish_schvouch_cheqno VARCHAR(20),
	mcfish_schvouch_cheqamt FLOAT(12,2),
	mcfish_schvouch_desc VARCHAR(100) NOT NULL,
	mcfish_schvouch_postdte DATE NOT NULL,
	mcfish_schvouch_authdte DATE,
	mcfish_schvouch_paydte DATE,
	mcfish_schvouch_amt FLOAT(12,2) NOT NULL,
	mcfish_schvouch_pamt FLOAT(12,2) NOT NULL,
	mcfish_schvouch_supplier CHAR(36) NOT NULL,
	mcfish_schvouch_img LONGBLOB,
	PRIMARY KEY (mcfish_schvouch_id),
	FOREIGN KEY (mcfish_schvouch_tenant)
		REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schvouch_actor)
		REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schvouch_payer)
		REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schvouch_authrz)
		REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schvouch_supplier)
		REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolAccReceipt ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolAccReceipt 
	(mcfish_schaccr_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schaccr_accid INT NOT NULL,
	mcfish_schaccr_desc VARCHAR(100) NOT NULL,
	mcfish_schaccr_pdate DATE NOT NULL,
	mcfish_schaccr_amt FLOAT(12,2) NOT NULL,
	mcfish_schaccr_tenant CHAR(36) NOT NULL,	
	PRIMARY KEY (mcfish_schaccr_id),
	FOREIGN KEY (mcfish_schaccr_tenant)
		REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schaccr_accid) 
		REFERENCES SchoolAccount (mcfish_schacc_id) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolAccRecVote ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolAccRecVote 
	(mcfish_schaccrv_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schaccrv_recid INT NOT NULL,
	mcfish_schaccrv_vote INT NOT NULL,
	mcfish_schaccrv_pdate DATE NOT NULL,
	mcfish_schaccrv_amt FLOAT(12,2) NOT NULL,
	mcfish_schaccrv_tenant CHAR(36) NOT NULL,	
	PRIMARY KEY (mcfish_schaccrv_id),
	FOREIGN KEY (mcfish_schaccrv_tenant)
		REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schaccrv_recid) 
		REFERENCES SchoolAccReceipt (mcfish_schaccr_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schaccrv_vote) 
		REFERENCES SchoolCharge (mcfish_schcharge_id) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolAccPayment ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolAccPayment 
	(mcfish_schaccp_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schaccp_accid INT NOT NULL,
	mcfish_schaccp_vpay INT NOT NULL,
	mcfish_schaccp_desc VARCHAR(100) NOT NULL,
	mcfish_schaccp_pdate DATE NOT NULL,
	mcfish_schaccp_amt FLOAT(12,2) NOT NULL,
	mcfish_schaccp_tenant CHAR(36) NOT NULL,	
	PRIMARY KEY (mcfish_schaccp_id),
	FOREIGN KEY (mcfish_schaccp_tenant)
		REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schaccp_accid) 
		REFERENCES SchoolAccount (mcfish_schacc_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schaccp_vpay) 
		REFERENCES SchoolPayVourcher (mcfish_schvouch_id) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolAccPayVote ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolAccPayVote 
	(mcfish_schaccrp_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schaccrp_payid INT NOT NULL,
	mcfish_schaccrp_vote INT NOT NULL,
	mcfish_schaccrp_vpay INT NOT NULL,
	mcfish_schaccrp_pdate DATE NOT NULL,
	mcfish_schaccrp_amt FLOAT(12,2) NOT NULL,
	mcfish_schaccrp_tenant CHAR(36) NOT NULL,	
	PRIMARY KEY (mcfish_schaccrp_id),
	FOREIGN KEY (mcfish_schaccrp_tenant)
		REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schaccrp_payid) 
		REFERENCES SchoolAccPayment (mcfish_schaccp_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schaccrp_vote) 
		REFERENCES SchoolCharge (mcfish_schcharge_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schaccrp_vpay)
		REFERENCES SchoolPayVourcher (mcfish_schvouch_id) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolLedger ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolLedger 
	(mcfish_schleg_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schleg_voteid INT NOT NULL,
	mcfish_schleg_pdate DATE NOT NULL,
	mcfish_schleg_desc VARCHAR(100) NOT NULL,
	mcfish_schleg_damt FLOAT(12,2) NOT NULL,
	mcfish_schleg_camt FLOAT(12,2) NOT NULL,
	mcfish_schleg_tenant CHAR(36) NOT NULL,
	mcfish_schleg_idbal TINYINT(1) NOT NULL,	
	PRIMARY KEY (mcfish_schleg_id),
	FOREIGN KEY (mcfish_schleg_tenant)
		REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schleg_voteid) 
		REFERENCES SchoolCharge (mcfish_schcharge_id) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolSubject ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolSubject
	(mcfish_schsub_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schsub_tenant CHAR(36) NOT NULL,
	mcfish_schsub_code VARCHAR(10) NOT NULL,
	mcfish_schsub_scode VARCHAR(10) NOT NULL,
	mcfish_schsub_desc VARCHAR(100) NOT NULL,
	mcfish_schsub_area ENUM('COMPULSORY', 'UCU', 'NA', 'OTHERS') NOT NULL,
	mcfish_schsub_prereq INT,
	mcfish_schsub_course INT NOT NULL,
	mcfish_schsub_lvl INT NOT NULL,
	PRIMARY KEY (mcfish_schsub_id),
	UNIQUE (mcfish_schsub_tenant, mcfish_schsub_code, mcfish_schsub_course),
	UNIQUE (mcfish_schsub_tenant, mcfish_schsub_scode, mcfish_schsub_course),
	UNIQUE (mcfish_schsub_tenant, mcfish_schsub_desc, mcfish_schsub_course),
	FOREIGN KEY (mcfish_schsub_lvl)		 
		REFERENCES SchoolLevel(mcfish_schlvl_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schsub_prereq)		 
		REFERENCES SchoolSubject(mcfish_schsub_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schsub_course)		 
		REFERENCES SchoolCourse(mcfish_schcrse_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schsub_tenant)		 
		REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolSubjectReq ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolSubjectReq
	(mcfish_schsubreq_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schsubreq_tenant CHAR(36) NOT NULL,
	mcfish_schsubreq_lvl INT NOT NULL,
	mcfish_schsubreq_area ENUM('COMPULSORY', 'SCIENCE', 'HUMANITY', 'TECHNICALANDAPPLIED', 'OTHERS') NOT NULL,
	mcfish_schsubreq_count INT NOT NULL,
	PRIMARY KEY (mcfish_schsubreq_id),
	UNIQUE (mcfish_schsubreq_lvl, mcfish_schsubreq_area),
	FOREIGN KEY (mcfish_schsubreq_tenant)		 
		REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schsubreq_lvl)		 
		REFERENCES SchoolLevel(mcfish_schlvl_id) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolLevelSubject ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolLevelSubject
	(mcfish_schlvlsub_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schlvlsub_tenant CHAR(36) NOT NULL,
	mcfish_schlvlsub_lvl INT NOT NULL,
	mcfish_schlvlsub_sub INT NOT NULL,
	mcfish_schlvlsub_core TINYINT(1) NOT NULL,
	mcfish_schlvlsub_exampc INT NOT NULL,
	mcfish_schlvlsub_examct INT NOT NULL,
	mcfish_schlvlsub_catpc INT NOT NULL,
	mcfish_schlvlsub_catct INT NOT NULL,
	mcfish_schlvlsub_asspc INT NOT NULL,
	mcfish_schlvlsub_assct INT NOT NULL,
	mcfish_schlvlsub_labpc INT NOT NULL,
	mcfish_schlvlsub_labct INT NOT NULL,
	PRIMARY KEY (mcfish_schlvlsub_id),
	UNIQUE (mcfish_schlvlsub_lvl, mcfish_schlvlsub_sub),
	FOREIGN KEY (mcfish_schlvlsub_tenant)		 
		REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schlvlsub_lvl)		 
		REFERENCES SchoolLevel(mcfish_schlvl_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schlvlsub_sub)		 
		REFERENCES SchoolSubject(mcfish_schsub_id) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolSubjectExamMapping ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolSubjectExamMapping
	(mcfish_schsubxmap_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schsubxmap_tenant CHAR(36) NOT NULL,
	mcfish_schsubxmap_sub INT NOT NULL,
	mcfish_schsubxmap_from INT NOT NULL,
	mcfish_schsubxmap_to INT NOT NULL,
	mcfish_schsubxmap_grade CHAR(3) NOT NULL,
	PRIMARY KEY (mcfish_schsubxmap_id),
	UNIQUE (mcfish_schsubxmap_tenant, mcfish_schsubxmap_from, mcfish_schsubxmap_sub),
	UNIQUE (mcfish_schsubxmap_tenant, mcfish_schsubxmap_to, mcfish_schsubxmap_sub),
	FOREIGN KEY (mcfish_schsubxmap_tenant)		 
		REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schsubxmap_sub)		 
		REFERENCES SchoolSubject(mcfish_schsub_id) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolSubExam ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolSubExam
	(mcfish_schsubexam_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schsubexam_tenant CHAR(36) NOT NULL,
	mcfish_schsubexam_sub INT NOT NULL,
	mcfish_schsubexam_term INT NOT NULL,
	mcfish_schsubexam_year INT NOT NULL,
	mcfish_schsubexam_teacher CHAR(36),
	mcfish_schsubexam_img LONGBLOB,
	mcfish_schsubexam_duedte DATE,
	mcfish_schsubexam_exdte DATE,
	mcfish_schsubexam_done TINYINT(1) NOT NULL,
	mcfish_schsubexam_venue VARCHAR(50),
	PRIMARY KEY (mcfish_schsubexam_id),
	UNIQUE (mcfish_schsubexam_sub, mcfish_schsubexam_year, mcfish_schsubexam_term),
	FOREIGN KEY (mcfish_schsubexam_tenant)		 
		REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schsubexam_sub)		 
		REFERENCES SchoolSubject(mcfish_schsub_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schsubexam_teacher)		 
		REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolExamMapping ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolExamMapping
	(mcfish_schxmap_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schxmap_tenant CHAR(36) NOT NULL,
	mcfish_schxmap_cls INT NOT NULL,
	mcfish_schxmap_from INT NOT NULL,
	mcfish_schxmap_to INT NOT NULL,	
	mcfish_schxmap_grade CHAR(3) NOT NULL,
	PRIMARY KEY (mcfish_schxmap_id),
	UNIQUE (mcfish_schxmap_tenant, mcfish_schxmap_from, mcfish_schxmap_cls),
	UNIQUE (mcfish_schxmap_tenant, mcfish_schxmap_to, mcfish_schxmap_cls),
	FOREIGN KEY (mcfish_schxmap_tenant)		 
		REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schxmap_cls)		 
		REFERENCES SchoolLevel(mcfish_schlvl_id) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolExamReviewer ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolExamReviewer
	(mcfish_schexrev_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schexrev_tenant CHAR(36) NOT NULL,
	mcfish_schexrev_exam INT NOT NULL,
	mcfish_schexrev_rvwr CHAR(36) NOT NULL,
	mcfish_schexrev_done TINYINT(1) NOT NULL,
	PRIMARY KEY (mcfish_schexrev_id),
	UNIQUE (mcfish_schexrev_exam, mcfish_schexrev_rvwr),
	FOREIGN KEY (mcfish_schexrev_tenant)		 
		REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schexrev_exam)		 
		REFERENCES SchoolSubExam(mcfish_schsubexam_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schexrev_rvwr)		 
		REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolReviewerComment ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolReviewerComment
	(mcfish_schexrev_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schexrev_tenant CHAR(36) NOT NULL,
	mcfish_schexrev_rvw INT NOT NULL,
	mcfish_schexrev_comment VARCHAR(50) NOT NULL,
	PRIMARY KEY (mcfish_schexrev_id),
	FOREIGN KEY (mcfish_schexrev_tenant)		 
		REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schexrev_rvw)
		REFERENCES SchoolExamReviewer(mcfish_schexrev_id) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolSubSyllabus ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolSubSyllabus
	(mcfish_schsubsyl_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schsubsyl_tenant CHAR(36) NOT NULL,
	mcfish_schsubsyl_sub INT NOT NULL,
	mcfish_schsubsyl_desc VARCHAR(50) NOT NULL,
	mcfish_schsubsyl_comment VARCHAR(200),
	PRIMARY KEY (mcfish_schsubsyl_id),
	UNIQUE (mcfish_schsubsyl_sub, mcfish_schsubsyl_desc),
	FOREIGN KEY (mcfish_schsubsyl_tenant)		 
		REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schsubsyl_sub)
		REFERENCES SchoolSubject(mcfish_schsub_id) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolSyllLibrary ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolSyllLibrary
	(mcfish_schsylib_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schsylib_tenant CHAR(36) NOT NULL,
	mcfish_schsylib_syl INT NOT NULL,
	mcfish_schsylib_desc VARCHAR(100) NOT NULL,
	mcfish_schsylib_img LONGBLOB NOT NULL,
	PRIMARY KEY (mcfish_schsylib_id),
	FOREIGN KEY (mcfish_schsylib_tenant)		 
		REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schsylib_syl)
		REFERENCES SchoolSubSyllabus(mcfish_schsubsyl_id) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolSyllExams ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolSyllExams
	(mcfish_schsylexm_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schsylexm_tenant CHAR(36) NOT NULL,
	mcfish_schsylexm_syl INT NOT NULL,
	mcfish_schsylexm_qst VARCHAR(1000) NOT NULL,
	mcfish_schsylexm_mrks FLOAT(6, 2) NOT NULL,
	PRIMARY KEY (mcfish_schsylexm_id),
	FOREIGN KEY (mcfish_schsylexm_tenant)		 
		REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schsylexm_syl)
		REFERENCES SchoolSubSyllabus(mcfish_schsubsyl_id) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolExamMultiChoice ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolExamMultiChoice
	(mcfish_schexmlt_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schexmlt_tenant CHAR(36) NOT NULL,
	mcfish_schexmlt_exam INT NOT NULL,
	mcfish_schexmlt_choice VARCHAR(100) NOT NULL,
	PRIMARY KEY (mcfish_schexmlt_id),
	FOREIGN KEY (mcfish_schexmlt_tenant)		 
		REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schexmlt_exam)
		REFERENCES SchoolSyllExams(mcfish_schsylexm_id) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolExamResult ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolExamResult
	(mcfish_schexmr_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schexmr_tenant CHAR(36) NOT NULL,
	mcfish_schexmr_exam INT NOT NULL,
	mcfish_schexmr_rst VARCHAR(1000),
	mcfish_schexmr_mult INT,
	PRIMARY KEY (mcfish_schexmr_id),
	FOREIGN KEY (mcfish_schexmr_tenant)		 
		REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schexmr_exam)
		REFERENCES SchoolSyllExams(mcfish_schsylexm_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schexmr_mult)
		REFERENCES SchoolExamMultiChoice(mcfish_schexmlt_id) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolStudSubject ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolStudSubject
	(mcfish_schstusub_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schstusub_tenant CHAR(36) NOT NULL,
	mcfish_schstusub_stud CHAR(36) NOT NULL,
	mcfish_schstusub_lvl INT NOT NULL,
	mcfish_schstusub_term INT NOT NULL,
	mcfish_schstusub_year INT NOT NULL,
	mcfish_schstusub_sub INT NOT NULL,
	mcfish_schstusub_core TINYINT(1) NOT NULL,
	mcfish_schstusub_ragr FLOAT(5,2) NOT NULL,
	mcfish_schstusub_agr FLOAT(5,2) NOT NULL,
	mcfish_schstusub_rgrd VARCHAR(6) NOT NULL,
	mcfish_schstusub_grd VARCHAR(6) NOT NULL,
	mcfish_schstusub_clsno INT NOT NULL,
	mcfish_schstusub_strno INT NOT NULL,
	PRIMARY KEY (mcfish_schstusub_id),
	UNIQUE (mcfish_schstusub_stud, mcfish_schstusub_lvl, mcfish_schstusub_term, mcfish_schstusub_year, mcfish_schstusub_sub),
	FOREIGN KEY (mcfish_schstusub_tenant)		 
		REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schstusub_lvl)		 
		REFERENCES SchoolLevel(mcfish_schlvl_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schstusub_sub)		 
		REFERENCES SchoolSubject(mcfish_schsub_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schstusub_stud)		 
		REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolStudAgregate ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolStudAgregate
	(mcfish_schstuagr_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schstuagr_tenant CHAR(36) NOT NULL,
	mcfish_schstuagr_stud CHAR(36) NOT NULL,
	mcfish_schstuagr_lvl INT NOT NULL,
	mcfish_schstuagr_term INT NOT NULL,
	mcfish_schstuagr_year INT NOT NULL,
	mcfish_schstuagr_agr FLOAT(5,2) NOT NULL,
	mcfish_schstuagr_grd VARCHAR(6) NOT NULL,
	mcfish_schstuagr_clsno INT NOT NULL,
	mcfish_schstuagr_strno INT NOT NULL,
	mcfish_schstuagr_calc TINYINT(1) NOT NULL,
	PRIMARY KEY (mcfish_schstuagr_id),
	UNIQUE (mcfish_schstuagr_stud, mcfish_schstuagr_lvl, mcfish_schstuagr_term, mcfish_schstuagr_year),
	FOREIGN KEY (mcfish_schstuagr_tenant)		 
		REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schstuagr_lvl)		 
		REFERENCES SchoolLevel(mcfish_schlvl_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schstuagr_stud)		 
		REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolStudExamAgregate ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolStudExamAgregate
	(mcfish_schstueagr_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schstueagr_tenant CHAR(36) NOT NULL,
	mcfish_schstueagr_stud CHAR(36) NOT NULL,
	mcfish_schstueagr_lvl INT NOT NULL,
	mcfish_schstueagr_term INT NOT NULL,
	mcfish_schstueagr_year INT NOT NULL,
	mcfish_schstueagr_agr FLOAT(5,2) NOT NULL,
	mcfish_schstueagr_grd VARCHAR(6) NOT NULL,
	mcfish_schstueagr_clsno INT NOT NULL,
	mcfish_schstueagr_strno INT NOT NULL,
	mcfish_schstueagr_calc TINYINT(1) NOT NULL,
	mcfish_schstueagr_area ENUM('CAT', 'EXAM', 'ASSIGNMENT', 'LAB', 'NA') NOT NULL,
	mcfish_schstueagr_no INT NOT NULL,
	PRIMARY KEY (mcfish_schstueagr_id),
	UNIQUE (mcfish_schstueagr_stud, mcfish_schstueagr_lvl, mcfish_schstueagr_term, mcfish_schstueagr_year, mcfish_schstueagr_area, mcfish_schstueagr_no),
	FOREIGN KEY (mcfish_schstueagr_tenant)		 
		REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schstueagr_lvl)		 
		REFERENCES SchoolLevel(mcfish_schlvl_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schstueagr_stud)		 
		REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolStudSubTarget ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolStudSubTarget
	(mcfish_schstsubt_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schstsubt_stsub INT NOT NULL,
	mcfish_schstsubt_prc INT,
	mcfish_schstsubt_aprc INT,
	mcfish_schstsubt_grd ENUM('A_PLUS', 'A', 'A_MINUS', 'B_PLUS', 'B', 'B_MINUS', 'C_PLUS', 'C', 'C_MINUS', 'D_PLUS', 'D', 'D_MINUS', 'E_PLUS', 'E', 'E_MINUS', 'F_PLUS', 'F', 'F_MINUS', 'NA', 'FAIL', 'INCOMPLETE', 'PASS'),
	mcfish_schstsubt_agrd ENUM('A_PLUS', 'A', 'A_MINUS', 'B_PLUS', 'B', 'B_MINUS', 'C_PLUS', 'C', 'C_MINUS', 'D_PLUS', 'D', 'D_MINUS', 'E_PLUS', 'E', 'E_MINUS', 'F_PLUS', 'F', 'F_MINUS', 'NA', 'FAIL', 'INCOMPLETE', 'PASS'),
	PRIMARY KEY (mcfish_schstsubt_id),
	UNIQUE (mcfish_schstsubt_stsub),
	FOREIGN KEY (mcfish_schstsubt_stsub)		 
		REFERENCES SchoolStudSubject(mcfish_schstusub_id) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolStudMarx ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolStudMarx
	(mcfish_schstmax_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schstmax_stsub INT NOT NULL,
	mcfish_schstmax_max INT NOT NULL,
	mcfish_schstmax_ttl INT NOT NULL,
	mcfish_schstmax_no INT NOT NULL,
	mcfish_schstmax_conv INT NOT NULL,
	mcfish_schstmax_grade VARCHAR(20) NOT NULL,
	mcfish_schstmax_area ENUM('CAT', 'EXAM', 'ASSIGNMENT', 'LAB', 'NA') NOT NULL,
	mcfish_schstmax_clsno INT NOT NULL,
	mcfish_schstmax_strno INT NOT NULL,
	mcfish_schstmax_pc INT NOT NULL,
	mcfish_schstmax_calc TINYINT(1) NOT NULL,
	PRIMARY KEY (mcfish_schstmax_id),
	FOREIGN KEY (mcfish_schstmax_stsub)	 
		REFERENCES SchoolStudSubject(mcfish_schstusub_id) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolStudMarxArea ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolStudMarxArea
	(mcfish_schstmax_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schstmax_stmax INT NOT NULL,
	mcfish_schstmax_area INT NOT NULL,
	mcfish_schstmax_max INT NOT NULL,
	mcfish_schstmax_ttl INT NOT NULL,
	mcfish_schstmax_comments VARCHAR(50),
	PRIMARY KEY (mcfish_schstmax_id),
	UNIQUE (mcfish_schstmax_stmax, mcfish_schstmax_area),
	FOREIGN KEY (mcfish_schstmax_stmax)		 
		REFERENCES SchoolStudMarx(mcfish_schstmax_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schstmax_area)		 
		REFERENCES SchoolSubSyllabus(mcfish_schsubsyl_id) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating TeacherSubAssignment ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS TeacherSubAssignment
	(mcfish_tsa_id INT NOT NULL AUTO_INCREMENT,
	mcfish_tsa_tenant CHAR(36) NOT NULL,
	mcfish_tsa_teacher CHAR(36) NOT NULL,
	mcfish_tsa_sub INT NOT NULL,
	mcfish_tsa_cls INT NOT NULL,
	PRIMARY KEY (mcfish_tsa_id),
	UNIQUE (mcfish_tsa_tenant, mcfish_tsa_teacher, mcfish_tsa_sub, mcfish_tsa_cls),
	FOREIGN KEY (mcfish_tsa_tenant)		 
		REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_tsa_cls)		 
		REFERENCES SchoolClass(mcfish_schcls_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_tsa_sub)		 
		REFERENCES SchoolSubject(mcfish_schsub_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_tsa_teacher)		 
		REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolStudSponsor ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolStudSponsor
	(mcfish_schspo_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schspo_tenant CHAR(36) NOT NULL,
	mcfish_schspo_guard CHAR(36) NOT NULL,
	mcfish_schspo_stu CHAR(36) NOT NULL,
	PRIMARY KEY (mcfish_schspo_id),
	UNIQUE (mcfish_schspo_guard, mcfish_schspo_stu),
	FOREIGN KEY (mcfish_schspo_tenant)		 
		REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schspo_guard)	 
		REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schspo_stu)		 
		REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolLibSetting ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolLibSetting 
	(mcfish_schlibstg_id CHAR(36) NOT NULL,
	mcfish_schlibstg_maxbwd INT NOT NULL,
	mcfish_schlibstg_maxbdys INT NOT NULL,
	mcfish_schlibstg_fee FLOAT(6,2),
	mcfish_schlibstg_feedys INT,
	mcfish_schlibstg_feex FLOAT(6,2),
	mcfish_schlibstg_feexdys INT,
	mcfish_schlibstg_feey FLOAT(6,2),
	mcfish_schlibstg_feeydys INT,
	PRIMARY KEY (mcfish_schlibstg_id),
	FOREIGN KEY (mcfish_schlibstg_id)		 
			REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolLibEdition ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolLibEdition 
	(mcfish_schlibedt_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schlibedt_desc VARCHAR(50) NOT NULL,
	mcfish_schlibedt_tenant CHAR(36) NOT NULL,
	PRIMARY KEY (mcfish_schlibedt_id),
	UNIQUE (mcfish_schlibedt_tenant, mcfish_schlibedt_desc),
	FOREIGN KEY (mcfish_schlibedt_tenant)		 
			REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolLibLocation ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolLibLocation 
	(mcfish_schlibloc_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schlibloc_desc VARCHAR(50) NOT NULL,
	mcfish_schlibloc_tenant CHAR(36) NOT NULL,
	PRIMARY KEY (mcfish_schlibloc_id),
	UNIQUE (mcfish_schlibloc_tenant, mcfish_schlibloc_desc),
	FOREIGN KEY (mcfish_schlibloc_tenant)		 
			REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolLibShelf ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolLibShelf 
	(mcfish_schlibshf_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schlibshf_desc VARCHAR(50) NOT NULL,
	mcfish_schlibshf_loc INT NOT NULL,
	mcfish_schlibshf_tenant CHAR(36) NOT NULL,
	PRIMARY KEY (mcfish_schlibshf_id),
	UNIQUE (mcfish_schlibshf_tenant, mcfish_schlibshf_desc, mcfish_schlibshf_loc),
	FOREIGN KEY (mcfish_schlibshf_loc)		 
			REFERENCES SchoolLibLocation(mcfish_schlibloc_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schlibshf_tenant)		 
			REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolLibPublisher ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolLibPublisher 
	(mcfish_schlibpub_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schlibpub_desc VARCHAR(100) NOT NULL,
	mcfish_schlibpub_tenant CHAR(36) NOT NULL,
	PRIMARY KEY (mcfish_schlibpub_id),
	UNIQUE (mcfish_schlibpub_tenant, mcfish_schlibpub_desc),
	FOREIGN KEY (mcfish_schlibpub_tenant)		 
			REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolLibAuthor ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolLibAuthor 
	(mcfish_schlibath_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schlibath_desc VARCHAR(200) NOT NULL,
	mcfish_schlibath_tenant CHAR(36) NOT NULL,
	PRIMARY KEY (mcfish_schlibath_id),
	UNIQUE (mcfish_schlibath_tenant, mcfish_schlibath_desc),
	FOREIGN KEY (mcfish_schlibath_tenant)		 
			REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolLibSubject ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolLibSubject 
	(mcfish_schlibsbj_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schlibsbj_desc VARCHAR(100) NOT NULL,
	mcfish_schlibsbj_tenant CHAR(36) NOT NULL,
	PRIMARY KEY (mcfish_schlibsbj_id),
	UNIQUE (mcfish_schlibsbj_tenant, mcfish_schlibsbj_desc),
	FOREIGN KEY (mcfish_schlibsbj_tenant)		 
			REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolLibBook ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolLibBook 
	(mcfish_schlibbk_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schlibbk_refno VARCHAR(10) NOT NULL,
	mcfish_schlibbk_tenant CHAR(36) NOT NULL,
	mcfish_schlibbk_title VARCHAR(100) NOT NULL,
	mcfish_schlibbk_author INT NOT NULL,
	mcfish_schlibbk_psher INT NOT NULL,
	mcfish_schlibbk_yrpub DATETIME NOT NULL,
	mcfish_schlibbk_shelfno INT NOT NULL,
	mcfish_schlibbk_sbj INT NOT NULL,
	mcfish_schlibbk_isbn VARCHAR(10) NOT NULL,
	mcfish_schlibbk_editn INT NOT NULL,
	mcfish_schlibbk_cost FLOAT(8,2) NOT NULL,
	mcfish_schlibbk_rcost FLOAT(8,2) NOT NULL,
	mcfish_schlibbk_doe DATETIME NOT NULL,
	mcfish_schlibbk_isborwble TINYINT(1) NOT NULL,
	mcfish_schlibbk_maxbdys INT,
	mcfish_schlibbk_fee FLOAT(6,2),
	mcfish_schlibbk_feedys INT,
	mcfish_schlibbk_feex FLOAT(6,2),
	mcfish_schlibbk_feexdys INT,
	mcfish_schlibbk_feey FLOAT(6,2),
	mcfish_schlibbk_feeydys INT,
	mcfish_schlibbk_img BLOB,	
	PRIMARY KEY (mcfish_schlibbk_id),
	UNIQUE (mcfish_schlibbk_tenant, mcfish_schlibbk_refno),
	UNIQUE (mcfish_schlibbk_tenant, mcfish_schlibbk_title, mcfish_schlibbk_author, mcfish_schlibbk_editn),
	FOREIGN KEY (mcfish_schlibbk_sbj)
			REFERENCES SchoolLibSubject(mcfish_schlibsbj_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schlibbk_tenant)
			REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schlibbk_author)
			REFERENCES SchoolLibAuthor(mcfish_schlibath_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schlibbk_psher)
			REFERENCES SchoolLibPublisher(mcfish_schlibpub_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schlibbk_editn)
			REFERENCES SchoolLibEdition(mcfish_schlibedt_id) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolBook ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolBook 
	(mcfish_schbk_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schbk_tenant CHAR(36) NOT NULL,
	mcfish_schbk_bkid INT NOT NULL,
	mcfish_schbk_libno INT NOT NULL,
	mcfish_schbk_lastbrw DATETIME,
	mcfish_schbk_lastrtrn DATETIME,
	mcfish_schbk_nobrwd INT NOT NULL,
	mcfish_schbk_lbrwrid CHAR(36),
	mcfish_schbk_rsvdby CHAR(36),
	mcfish_schbk_rsvdon DATETIME,
	mcfish_schbk_duedte DATETIME,
	mcfish_schbk_issloan TINYINT(1) NOT NULL,
	mcfish_schbk_stts ENUM('LOANED', 'AVAILABLE', 'OVERDUE', 'RESERVED', 'NA', 'LOST') NOT NULL,
	mcfish_schbk_notes VARCHAR(300),
	mcfish_schbk_img LONGBLOB,
	PRIMARY KEY (mcfish_schbk_id),
	UNIQUE (mcfish_schbk_tenant, mcfish_schbk_bkid, mcfish_schbk_libno),
	FOREIGN KEY (mcfish_schbk_tenant)
			REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schbk_bkid)
			REFERENCES SchoolLibBook(mcfish_schlibbk_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schbk_lbrwrid)
			REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schbk_rsvdby)
			REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolBookHist ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolBookHist 
	(mcfish_schbkhst_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schbkhst_tenant CHAR(36) NOT NULL,
	mcfish_schbkhst_bkid INT NOT NULL,
	mcfish_schbkhst_brwrid CHAR(38) NOT NULL,
	mcfish_schbkhst_dte DATETIME NOT NULL,
	mcfish_schbkhst_rdte DATETIME,
	mcfish_schbkhst_charge FLOAT(12,2) NOT NULL,
	mcfish_schbkhst_paid TINYINT(1) NOT NULL,
	mcfish_schbkhst_pmode ENUM('CASH', 'FEE', 'NA') NOT NULL,
	mcfish_schbkhst_paidby CHAR(38),
	mcfish_schbkhst_paiddte DATETIME,
	PRIMARY KEY (mcfish_schbkhst_id),
	FOREIGN KEY (mcfish_schbkhst_tenant)
			REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schbkhst_bkid)
			REFERENCES SchoolBook(mcfish_schbk_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schbkhst_brwrid)
			REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolBookReserve ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolBookReserve 
	(mcfish_schbkrsv_id INT NOT NULL AUTO_INCREMENT,
	mcfish_schbkrsv_tenant CHAR(36) NOT NULL,
	mcfish_schbkrsv_bkid INT NOT NULL,
	mcfish_schbkrsv_binstid INT,
	mcfish_schbkrsv_by CHAR(36) NOT NULL,
	mcfish_schbkrsv_dte DATETIME NOT NULL,
	mcfish_schbkrsv_avldte DATETIME,
	mcfish_schbkrsv_erwait DATETIME,
	PRIMARY KEY (mcfish_schbkrsv_id),
	FOREIGN KEY (mcfish_schbkrsv_tenant)
			REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schbkrsv_bkid)
			REFERENCES SchoolLibBook(mcfish_schlibbk_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schbkrsv_binstid)
			REFERENCES SchoolBook(mcfish_schbk_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schbkrsv_by)
			REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating SchoolLibMember ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolLibMember
	(mcfish_schmbr_mid CHAR(36) NOT NULL,
	mcfish_schmbr_tenant CHAR(36) NOT NULL,
	mcfish_schmbr_no VARCHAR(20) NOT NULL,
	mcfish_schmbr_status ENUM('Active', 'Disabled') NOT NULL,
	mcfish_schmbr_sttsdte DATETIME,
	mcfish_schmbr_from DATETIME NOT NULL,
	mcfish_schmbr_to DATETIME,
	mcfish_schmbr_maxbrw INT,
	mcfish_schmbr_modby CHAR(36) NOT NULL,
	PRIMARY KEY (mcfish_schmbr_mid),
	UNIQUE (mcfish_schmbr_tenant, mcfish_schmbr_no),
	FOREIGN KEY (mcfish_schmbr_tenant)
			REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schmbr_mid)
			REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_schmbr_modby)
			REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

# InventoryUnit
printf "Creating InventoryUnit ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS InventoryUnit 
	(mcfish_invunt_id INT NOT NULL AUTO_INCREMENT,
	mcfish_invunt_tenant CHAR(36) NOT NULL,
	mcfish_invunt_desc VARCHAR(20) NOT NULL,
	PRIMARY KEY (mcfish_invunt_id),
	UNIQUE (mcfish_invunt_tenant, mcfish_invunt_desc),
	FOREIGN KEY (mcfish_invunt_tenant)
			REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating InventoryItem ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS InventoryItem 
	(mcfish_invitm_id INT NOT NULL AUTO_INCREMENT,
	mcfish_invitm_tenant CHAR(36) NOT NULL,
	mcfish_invitm_unit INT NOT NULL,
	mcfish_invitm_code VARCHAR(4),
	mcfish_invitm_name VARCHAR(100) NOT NULL,
	mcfish_invitm_pprize FLOAT(12,2) NOT NULL,
	mcfish_invitm_sprize FLOAT(12,2) NOT NULL,
	mcfish_invitm_dins INT NOT NULL,
	mcfish_invitm_reorderlvl INT NOT NULL,
	mcfish_invitm_alertlvl INT NOT NULL,
	mcfish_invitm_modby CHAR(36) NOT NULL,
	PRIMARY KEY (mcfish_invitm_id),
	UNIQUE (mcfish_invitm_tenant, mcfish_invitm_name),
	FOREIGN KEY (mcfish_invitm_tenant)
			REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_invitm_unit)
			REFERENCES InventoryUnit(mcfish_invunt_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_invitm_modby)
			REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating InventoryItemInst ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS InventoryItemInst 
	(mcfish_invinst_id INT NOT NULL AUTO_INCREMENT,
	mcfish_invinst_tenant CHAR(36) NOT NULL,
	mcfish_invinst_item INT NOT NULL,
	mcfish_invinst_sup CHAR(36) NOT NULL,
	mcfish_invinst_odte DATETIME NOT NULL,
	mcfish_invinst_expdte DATETIME NOT NULL,
	mcfish_invinst_expddte DATETIME NOT NULL,
	mcfish_invinst_ddte DATETIME,
	mcfish_invinst_ref VARCHAR(20),
	mcfish_invinst_qty INT NOT NULL,
	mcfish_invinst_vrch INT NOT NULL,
	mcfish_invinst_pamt FLOAT(12,2) NOT NULL,
	mcfish_invinst_samt FLOAT(12,2) NOT NULL,
	mcfish_invinst_modby CHAR(36) NOT NULL,
	PRIMARY KEY (mcfish_invinst_id),
	FOREIGN KEY (mcfish_invinst_vrch)
			REFERENCES SchoolPayVourcher(mcfish_schvouch_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_invinst_tenant)
			REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_invinst_item)
			REFERENCES InventoryItem(mcfish_invitm_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_invinst_sup)
			REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_invinst_modby)
			REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating InventoryItemOrder ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS InventoryItemOrder 
	(mcfish_invodr_id INT NOT NULL AUTO_INCREMENT,
	mcfish_invodr_tenant CHAR(36) NOT NULL,
	mcfish_invodr_by CHAR(36) NOT NULL,
	mcfish_invodr_item INT NOT NULL,
	mcfish_invodr_ddte DATETIME NOT NULL,
	mcfish_invodr_odte DATETIME NOT NULL,
	mcfish_invodr_expddte DATETIME NOT NULL,
	mcfish_invodr_qty INT NOT NULL,
	mcfish_invodr_dlvrd INT NOT NULL,
	mcfish_invodr_amt FLOAT(12,2) NOT NULL,
	mcfish_invodr_modby CHAR(36) NOT NULL,
	PRIMARY KEY (mcfish_invodr_id),
	FOREIGN KEY (mcfish_invodr_by)
			REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_invodr_tenant)
			REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_invodr_item)
			REFERENCES InventoryItem(mcfish_invitm_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_invodr_modby)
			REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating InventoryDelivery ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS InventoryDelivery 
	(mcfish_invdry_id INT NOT NULL AUTO_INCREMENT,
	mcfish_invdry_tenant CHAR(36) NOT NULL,
	mcfish_invdry_by CHAR(36) NOT NULL,
	mcfish_invdry_to CHAR(36) NOT NULL,
	mcfish_invdry_itemo INT NOT NULL,
	mcfish_invdry_iteminst INT NOT NULL,
	mcfish_invdry_qty INT NOT NULL,
	mcfish_invdry_ddte DATETIME NOT NULL,
	mcfish_invodr_rby CHAR(36) NOT NULL,
	PRIMARY KEY (mcfish_invdry_id),
	FOREIGN KEY (mcfish_invdry_by)
			REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_invdry_tenant)
			REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_invdry_itemo)
			REFERENCES InventoryItemOrder(mcfish_invodr_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_invdry_to)
			REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_invodr_rby)
			REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_invdry_iteminst)
			REFERENCES InventoryItemInst(mcfish_invinst_id) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

#	Alter SchoolStudAgregate
	printf "Alter SchoolStudAgregate ... \n"
	ExecuteSqlTableCommand "delimiter //
		ALTER TABLE SchoolStudAgregate ADD mcfish_schstueagr_pts INT;
		//"

#	Alter SchoolStudAgregate
	printf "Alter SchoolStudAgregate ... \n"
	ExecuteSqlTableCommand "delimiter //
		ALTER TABLE SchoolStudAgregate ADD mcfish_schstueagr_gpts VARCHAR(4);
		//"

#	Alter SchoolExamMapping 
	printf "Alter SchoolExamMapping ... \n"
	ExecuteSqlTableCommand "delimiter //
		ALTER TABLE SchoolExamMapping ADD mcfish_schxmap_pts INT;
		//"

#	Alter SchoolStudMarx 
	printf "Alter SchoolStudMarx ... \n"
	ExecuteSqlTableCommand "delimiter //
		ALTER TABLE SchoolStudMarx ADD mcfish_schstmax_pts INT;
		//"

#	Alter SchoolStudExamAgregate 
	printf "Alter SchoolStudExamAgregate ... \n"
	ExecuteSqlTableCommand "delimiter //
		ALTER TABLE SchoolStudExamAgregate ADD mcfish_schstueagr_pts INT,
							ADD mcfish_schstueagr_gpts VARCHAR(4);
		//"

#	Alter SchoolStudSubject
	printf "Alter SchoolStudSubject ... \n"
	ExecuteSqlTableCommand "delimiter //
		ALTER TABLE SchoolStudSubject ADD mcfish_schstusub_pts INT;
		//"

#	Alter SchoolSubjectExamMapping
	printf "Alter SchoolSubjectExamMapping ... \n"
	ExecuteSqlTableCommand "delimiter //
		ALTER TABLE SchoolSubjectExamMapping ADD mcfish_schsubxmap_pts INT;
		//"

#	Add SchoolAvgGrading
	printf "Creating SchoolAvgGrading ... \n"
	ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS SchoolAvgGrading
		(mcfish_schavgg_id INT NOT NULL AUTO_INCREMENT,
		mcfish_schavgg_tenant CHAR(36) NOT NULL,
		mcfish_schavgg_cls INT NOT NULL,
		mcfish_schavgg_from INT NOT NULL,
		mcfish_schavgg_to INT NOT NULL,	
		mcfish_schavgg_grade CHAR(3) NOT NULL,
		PRIMARY KEY (mcfish_schavgg_id),
		UNIQUE (mcfish_schavgg_tenant, mcfish_schavgg_cls, mcfish_schavgg_from),
		UNIQUE (mcfish_schavgg_tenant, mcfish_schavgg_cls, mcfish_schavgg_to),
		FOREIGN KEY (mcfish_schavgg_tenant)		 
			REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
		FOREIGN KEY (mcfish_schavgg_cls)		 
			REFERENCES SchoolLevel(mcfish_schlvl_id) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

#	Alter TenantTable
	printf "Alter TenantTable ... \n"
	ExecuteSqlTableCommand "delimiter //
		ALTER TABLE TenantTable ADD mcfish_tenant_addr VARCHAR(200),
						ADD mcfish_tenant_phone VARCHAR(20),
						ADD mcfish_tenant_code VARCHAR(10),
						ADD mcfish_tenant_town VARCHAR(100),
						ADD mcfish_tenant_email VARCHAR(100);
		//"

#	Alter Member
	printf "Alter Member ... \n"
	ExecuteSqlTableCommand "delimiter //
		ALTER TABLE Member MODIFY mcfish_memb_module ENUM('STUDENT', 'TEACHER', 'STAFF', 'SUBORDINATE', 'PARENT', 'SUPLIER', 'ACCOUNTANT', 'PRINCIPAL', 'ALL', 'INVENTORY', 'KITCHEN', 'DSA', 'LIBRARY') NOT NULL;
		//"

#	Alter SchoolStudent
	printf "Alter SchoolStudent ... \n"
	ExecuteSqlTableCommand "delimiter //
		ALTER TABLE SchoolStudent ADD mcfish_schstud_almnyr INT,
					  ADD mcfish_schstud_indexno VARCHAR(20),
					  ADD mcfish_schstud_idno VARCHAR(20);
		//"

#	DROP InventoryDelivery
	printf "Drop InventoryDelivery ... \n"
	ExecuteSqlTableCommand "delimiter //
		DROP TABLE IF EXISTS InventoryDelivery;
		//"

#	DROP InventoryItemOrder
	printf "Drop InventoryItemOrder ... \n"
	ExecuteSqlTableCommand "delimiter //
		DROP TABLE IF EXISTS InventoryItemOrder;
		//"

#	DROP InventoryStock
	printf "Drop InventoryStock ... \n"
	ExecuteSqlTableCommand "delimiter //
		DROP TABLE IF EXISTS InventoryStock;
		//"

#	DROP InventoryUsed
	printf "Drop InventoryUsed ... \n"
	ExecuteSqlTableCommand "delimiter //
		DROP TABLE IF EXISTS InventoryUsed;
		//"

#	DROP InventoryItemInst
	printf "Drop InventoryItemInst ... \n"
	ExecuteSqlTableCommand "delimiter //
		DROP TABLE IF EXISTS InventoryItemInst;
		//"

#	DROP InventoryOrder
	printf "Drop InventoryOrder ... \n"
	ExecuteSqlTableCommand "delimiter //
		DROP TABLE IF EXISTS InventoryOrder;
		//"

#	DROP InventoryItem
	printf "Drop InventoryItem ... \n"
	ExecuteSqlTableCommand "delimiter //
		DROP TABLE IF EXISTS InventoryItem;
		//"

printf "Creating InventoryItem ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS InventoryItem 
	(mcfish_invitm_id INT NOT NULL AUTO_INCREMENT,
	mcfish_invitm_tenant CHAR(36) NOT NULL,
	mcfish_invitm_unit INT NOT NULL,
	mcfish_invitm_qty INT NOT NULL,
	mcfish_invitm_code VARCHAR(4),
	mcfish_invitm_name VARCHAR(100) NOT NULL,
	mcfish_invitm_pprize FLOAT(12,2) NOT NULL,
	mcfish_invitm_sprize FLOAT(12,2) NOT NULL,
	mcfish_invitm_dins INT NOT NULL,
	mcfish_invitm_reorderlvl INT NOT NULL,
	mcfish_invitm_alertlvl INT NOT NULL,
	mcfish_invitm_modby CHAR(36) NOT NULL,
	PRIMARY KEY (mcfish_invitm_id),
	UNIQUE (mcfish_invitm_tenant, mcfish_invitm_name, mcfish_invitm_unit),
	FOREIGN KEY (mcfish_invitm_tenant)
			REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_invitm_unit)
			REFERENCES InventoryUnit(mcfish_invunt_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_invitm_modby)
			REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating InventoryOrder ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS InventoryOrder 
	(mcfish_invorder_id INT NOT NULL AUTO_INCREMENT,
	mcfish_invorder_tenant CHAR(36) NOT NULL,
	mcfish_invorder_code INT NOT NULL,
	mcfish_invorder_dte DATETIME NOT NULL,
	PRIMARY KEY (mcfish_invorder_id),
	FOREIGN KEY (mcfish_invorder_tenant)
			REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating InventoryItemInst ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS InventoryItemInst 
	(mcfish_invinst_id INT NOT NULL AUTO_INCREMENT,
	mcfish_invinst_tenant CHAR(36) NOT NULL,
	mcfish_invinst_order INT NOT NULL,
	mcfish_invinst_item INT NOT NULL,
	mcfish_invinst_odte DATETIME NOT NULL,
	mcfish_invinst_expdte DATETIME,
	mcfish_invinst_expddte DATETIME NOT NULL,
	mcfish_invinst_ddte DATETIME,
	mcfish_invinst_ref VARCHAR(20),
	mcfish_invinst_qty INT NOT NULL,
	mcfish_invinst_qtydlvrd INT NOT NULL,
	mcfish_invinst_qtysold INT NOT NULL,
	mcfish_invinst_pamt FLOAT(12,2) NOT NULL,
	mcfish_invinst_samt FLOAT(12,2) NOT NULL,
	mcfish_invinst_modby CHAR(36) NOT NULL,
	PRIMARY KEY (mcfish_invinst_id),
	FOREIGN KEY (mcfish_invinst_tenant)
			REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_invinst_item)
			REFERENCES InventoryItem(mcfish_invitm_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_invinst_order)
			REFERENCES InventoryOrder(mcfish_invorder_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_invinst_modby)
			REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating InventoryUsed ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS InventoryUsed 
	(mcfish_invused_id INT NOT NULL AUTO_INCREMENT,
	mcfish_invused_tenant CHAR(36) NOT NULL,
	mcfish_invused_itinst INT NOT NULL,
	mcfish_invused_odte DATETIME NOT NULL,
	mcfish_invused_expdte DATETIME,
	mcfish_invused_expddte DATETIME NOT NULL,
	mcfish_invused_ddte DATETIME,
	mcfish_invused_to CHAR(36),
	mcfish_invused_area ENUM('INVENTORY', 'KITCHEN', 'LIBRARY'),
	mcfish_invused_qty INT NOT NULL,
	mcfish_invused_qtydlvrd INT NOT NULL,
	mcfish_invused_used INT NOT NULL,
	mcfish_invused_modby CHAR(36) NOT NULL,
	PRIMARY KEY (mcfish_invused_id),
	FOREIGN KEY (mcfish_invused_tenant)
			REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_invused_itinst)
			REFERENCES InventoryItemInst(mcfish_invinst_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_invused_to)
			REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_invused_modby)
			REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating InventoryStock ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS InventoryStock 
	(mcfish_invstk_id INT NOT NULL AUTO_INCREMENT,
	mcfish_invstk_tenant CHAR(36) NOT NULL,
	mcfish_invstk_usdid INT NOT NULL,
	mcfish_invstk_dte DATETIME NOT NULL,
	mcfish_invstk_bal INT NOT NULL,
	mcfish_invstk_used INT NOT NULL,
	mcfish_invstk_modby CHAR(36) NOT NULL,
	PRIMARY KEY (mcfish_invstk_id),
	FOREIGN KEY (mcfish_invstk_tenant)
			REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_invstk_usdid)
			REFERENCES InventoryUsed(mcfish_invused_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_invstk_modby)
			REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating InventoryItemOrder ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS InventoryItemOrder 
	(mcfish_invodr_id INT NOT NULL AUTO_INCREMENT,
	mcfish_invodr_tenant CHAR(36) NOT NULL,
	mcfish_invodr_by CHAR(36),
	mcfish_invodr_order INT NOT NULL,
	mcfish_invodr_item INT NOT NULL,
	mcfish_invodr_ddte DATETIME,
	mcfish_invodr_odte DATETIME NOT NULL,
	mcfish_invodr_expddte DATETIME,
	mcfish_invodr_qty INT NOT NULL,
	mcfish_invodr_dlvrd INT NOT NULL,
	mcfish_invodr_amt FLOAT(12,2) NOT NULL,
	mcfish_invodr_modby CHAR(36) NOT NULL,
	PRIMARY KEY (mcfish_invodr_id),
	FOREIGN KEY (mcfish_invodr_by)
			REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_invodr_order)
			REFERENCES InventoryOrder(mcfish_invorder_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_invodr_tenant)
			REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_invodr_item)
			REFERENCES InventoryItem(mcfish_invitm_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_invodr_modby)
			REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating InventoryDelivery ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS InventoryDelivery 
	(mcfish_invdry_id INT NOT NULL AUTO_INCREMENT,
	mcfish_invdry_tenant CHAR(36) NOT NULL,
	mcfish_invdry_by CHAR(36) NOT NULL,
	mcfish_invdry_to CHAR(36) NOT NULL,
	mcfish_invdry_itemo INT NOT NULL,
	mcfish_invdry_iteminst INT NOT NULL,
	mcfish_invdry_qty INT NOT NULL,
	mcfish_invdry_ddte DATETIME NOT NULL,
	mcfish_invodr_rby CHAR(36) NOT NULL,
	mcfish_invodr_vrch INT,
	PRIMARY KEY (mcfish_invdry_id),
	FOREIGN KEY (mcfish_invodr_vrch)
			REFERENCES SchoolPayVourcher(mcfish_schvouch_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_invdry_by)
			REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_invdry_tenant)
			REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_invdry_itemo)
			REFERENCES InventoryItemOrder(mcfish_invodr_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_invdry_to)
			REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_invodr_rby)
			REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_invdry_iteminst)
			REFERENCES InventoryItemInst(mcfish_invinst_id) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating InventoryHead ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS InventoryHead 
	(mcfish_invhead_id INT NOT NULL AUTO_INCREMENT,
	mcfish_invhead_tenant CHAR(36) NOT NULL,
	mcfish_invhead_head CHAR(36) NOT NULL,
	mcfish_invhead_dte DATETIME NOT NULL,
	mcfish_invhead_modfyby CHAR(36) NOT NULL,
	mcfish_invhead_area ENUM('INVENTORY', 'KITCHEN', 'LIBRARY') NOT NULL,
	PRIMARY KEY (mcfish_invhead_id),
	UNIQUE (mcfish_invhead_tenant, mcfish_invhead_area),
	FOREIGN KEY (mcfish_invhead_head)
			REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_invhead_tenant)
			REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_invhead_modfyby)
			REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"

printf "Creating KCSEStudentGrade ... \n"
ExecuteSqlTableCommand "CREATE TABLE IF NOT EXISTS KCSEStudentGrade 
	(mcfish_kcsestu_id INT NOT NULL AUTO_INCREMENT,
	mcfish_kcsestu_tenant CHAR(36) NOT NULL,
	mcfish_kcsestu_stu CHAR(36) NOT NULL,
	mcfish_kcsestu_code VARCHAR(5) NOT NULL,
	mcfish_kcsestu_grade VARCHAR(10) NOT NULL,
	mcfish_kcsestu_point INT NOT NULL,
	mcfish_kcsestu_year INT NOT NULL,
	mcfish_kcsestu_dte DATETIME NOT NULL,
	mcfish_kcsestu_modfyby CHAR(36) NOT NULL,
	PRIMARY KEY (mcfish_kcsestu_id),
	UNIQUE (mcfish_kcsestu_stu, mcfish_kcsestu_code, mcfish_kcsestu_year),
	FOREIGN KEY (mcfish_kcsestu_stu)
			REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_kcsestu_tenant)
			REFERENCES TenantTable(mcfish_tenant_uuid) ON UPDATE CASCADE ON DELETE RESTRICT,
	FOREIGN KEY (mcfish_kcsestu_modfyby)
			REFERENCES Member(mcfish_memb_mbrid) ON UPDATE CASCADE ON DELETE RESTRICT) ENGINE=INNODB;"


