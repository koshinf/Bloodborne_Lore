xquery version "3.1";
declare variable $fileContent := string-join(
let $main := doc('/db/bloodborne/mainXML.xml')
let $tab := "&#x9;"
let $runes := $main//caryllRune/runeName/@runeList
let $attire := $main//attire/attireName/@attireList
let $weapons := $main//weapon/weaponName/@weaponList
let $firearms := $main//firearm/firearmName/@firearmList
let $npcs := $main//npcName/@npcList
let $bosses := $main/bossName/@bosslist
let $items := ($runes, $attire, $weapons, $firearms, $npcs, $bosses)

for $i in $items
let $iString := $i/string() 
let $iType := $i/parent::*/parent::*/name()
let $locations := $i/following::locationArea/location/@*
for $l in $locations

let $lString := $l/string() 
let $lType := $l/name()


let $concat := concat($iString, $tab, $iType, $tab, $lType, $tab, $lString)
return ($concat), '&#x10;');

let $filename := "bloodNet.tsv"
let $doc-db-uri := xmldb:store("/db/bloodborne", $filename, $fileContent, "text/plain")
return $doc-db-uri
(: output at :http://newtfire.org:8338/exist/rest/db/bloodborne/bloodNet.tsv ) :)      