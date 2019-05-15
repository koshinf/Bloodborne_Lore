<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns="http://purl.oclc.org/dsdl/schematron">
    
    <pattern>
        <rule context="location">
            <!--  This rule checks to see if the location text includes the place name. If it doesn't, then it throws an error. -->
            <!--2019-05-15 ebb: I have amended the rule below to make sure it is firing on mainXML.xml 
         Your earlier strategy (preserved in the lamp rule following this) is to check a string-joined list of ALL the tokens, which would mean they must all be present exactly in the order you want with no intervening punctuation to make a place valid. It was not working, however, on actual code that met that strict constraint in your mainXML, so I am thinking you might have been asking too much of Schematron to define the variable and set the test in the same test attribute. The Schematron way is to define the variable you want in a separate element before you write the test on it, as I've written below.    
            -->
            <let name="tokenList" value="tokenize(@place,'_')"/>
            <assert test="some $token in $tokenList satisfies contains(text(), $token)">
            Location text does not contain place attribute value, check for errors
            </assert>
            <!--ebb: In the rule above, this is basically how you set up a for loop in Schematron to test each value. If you wanted to write this to join all those tokens together (into a single value) spliced together with white spaces, write it thus (and this seems to work on mainXML.xml) I am not sure you really want the constraint to be so strict in real life, reviewing your code.:
        <let name="tokenList" value="string-join(tokenize(@place,'_'), ' ')"/>
            <assert test="contains(text(), $tokenList)">
            Location text does not contain place attribute value, check for errors
            </assert>    
            
            
            -->
            
      <!--2019-05-15 ebb: I commented out this rule because it's not working as written. Try rewriting it following the syntax pattern I provided above.      <assert test="
                
                (:This rule checks to see if the location text includes the lamp name. If it doesn't, then it throws an error.:)
                
                let $token := string-join(tokenize(./@lamp,'_'),' ')
                
                return contains(./text(),$token)
                
                ">Location text does not contain lamp attribute value, check for errors</assert>
            -->
        </rule>
    </pattern>
    
</schema>