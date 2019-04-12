<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    xmlns:exslt="http://exslt.org/common"
    xmlns="http://www.w3.org/2000/svg"
    version="3.0">
    
    <xsl:output
        method="text"
        indent="no"/>
    
    <xsl:variable name="bloodColl" as="document-node()+" select="collection('../XML/?select=mainXML.xml')"/>
    
    
    <!-- ARE YOU READY FOR THE TOKENATOR?!-->
    
    <xsl:variable name="refinedNPC" select="string-join($bloodColl//@npcList,'_')"/>
    
    <xsl:variable name="refinedBoss" select="string-join($bloodColl//@bossList,'_')"/>
    
    <xsl:variable name="refinedFirearm" select="string-join($bloodColl//@firearmList,'_')"/>
    
    <xsl:variable name="refinedPlace" select="string-join($bloodColl//@placeList,'_')"/>
    
    <xsl:variable name="refinedRune" select="string-join($bloodColl//@runeList,'_')"/>
    
    <xsl:variable name="refinedAttire" select="string-join($bloodColl//@attireList,'_')"/>
    
    <xsl:variable name="rawTotal" select="upper-case(concat($refinedNPC,'_',$refinedBoss,'_',$refinedFirearm,'_',$refinedPlace, '_',$refinedRune, '_',$refinedAttire))"/>
    
    <xsl:variable name="crap" select="('''S','OF','THE', 'AND')"/>
    
    <xsl:variable name="cleanTotal1" select="replace($rawTotal,$crap[1],'')"/>
    
    <xsl:variable name="cleanTotal2" select="replace($cleanTotal1,$crap[2],'')"/>
    
    <xsl:variable name="cleanTotal3" select="replace($cleanTotal2,$crap[3],'')"/>
    
    <xsl:variable name="cleanTotal4" select="replace($cleanTotal3,$crap[4],'')"/>
    
    <xsl:variable name="cleanTotal5" select="replace($cleanTotal4,'-','_')"/>
    
    <xsl:variable name="brokenTotal" select="tokenize($cleanTotal5,'_')"/>
    
    <xsl:variable name="refinedTotal" select="distinct-values($brokenTotal)"/>
    
    <xsl:variable name="weapons" select="$bloodColl//weapon"/>
    
    <xsl:variable name="npcs" select="$bloodColl//npc"/>
    
    <xsl:variable name="bosses" select="$bloodColl//boss"/>
    
    <xsl:variable name="firearms" select="$bloodColl//firearm"/>
    
    <xsl:variable name="runes" select="$bloodColl//caryllRune"/>
    
    <xsl:variable name="attires" select="$bloodColl//attire"/>
    
    <xsl:template match="/">
    
    <xsl:variable name="input" select="$refinedTotal"/>
    
    <xsl:for-each select="$input">
        
        <xsl:variable name="item" select="current()"/>
        
        <xsl:variable name="qualified" select="$attires/*[contains(upper-case(.), $item)]"/>
        
        <xsl:variable name="names" select="$qualified/../attireName/@attireList"/>
        
        <xsl:for-each select="$names">
            
            <xsl:variable name="string" select="concat(current(),'&#x9;', 'mentions','&#x9;',$item,'&#xa;')"/>
            
            <xsl:apply-templates select="$string"/>
            
        </xsl:for-each>
        
    </xsl:for-each>
    
    </xsl:template>
    
</xsl:stylesheet>