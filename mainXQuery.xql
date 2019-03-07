xquery version "3.1";
declare variable $ThisFileContains := string-join(
let $bb := doc("/db/bloodborne/mainXML.xml")
let $crList := $bb//caryllRune/runeName/@runeList/normalize-space()
let $weaponList := $bb//weapon/weaponName/@weaponList/normalize-space()
let $fireList := $bb//firearm/firearmName/@firearmList/normalize-space()
let $listAll := ($crList, $weaponList, $fireList)
let $tokens := 
 for $l in $listAll
  let $toks := tokenize($l, '_') 
  let $trimmedToks := tokenize($toks, "'")[1]
  return $trimmedToks
let $distToks := $tokens => distinct-values()
let $concepts := 
 for $d in $distToks
 let $matches := $bb//node()[contains(., $d)]/name()
 where count($matches) gt 2
 return $d
(: 2019-03-07 ebb: This list of concepts is something you may well want to adjust and use in different ways (not just in network analysis). For example, you should, right now, output this as an HTML list for your website! Change the count() factor, etc. :)
(: 2019-03-07 ebb: Now we begin the TSV plotting for the network analysis :)
for $c in $concepts
(: $c will be your edge connector. So we need to find source and target nodes that SHARE each of these :)
let $sourceNodes := $bb//equipment/*/*[contains(@*, $c)]
let $count := $sourceNodes => count()
for $s in $sourceNodes
let $sourceAtt := $s/name() 
let $targetNodes := $bb//equipment/*/*[not(contains(@*, $c))][contains(., $c)]/preceding-sibling::*[@*]
for $t in $targetNodes
let $targetAtt := $t/name()
return concat($s, '&#x9;', $sourceAtt, '&#x9;', $c, '&#x9;', $count, '&#x9;', $t, '&#x9;', $targetAtt),
'&#10;');
$ThisFileContains
