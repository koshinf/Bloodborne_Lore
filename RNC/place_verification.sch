<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns="http://purl.oclc.org/dsdl/schematron">
    
    <pattern>
        <rule context="location">
            
            <assert test="
                
                (:This rule checks to see if the location text includes the place name. If it doesn't, then it throws an error.:)
                
                let $token := string-join(tokenize(./@place,'_'),' ')
                
                return contains(./text(),$token)
                
                ">Location text does not contain place attribute value, check for errors</assert>
            
            <assert test="
                
                (:This rule checks to see if the location text includes the lamp name. If it doesn't, then it throws an error.:)
                
                let $token := string-join(tokenize(./@lamp,'_'),' ')
                
                return contains(./text(),$token)
                
                ">Location text does not contain lamp attribute value, check for errors</assert>
            
        </rule>
    </pattern>
    
</schema>