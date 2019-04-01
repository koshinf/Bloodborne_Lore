<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="3.0">

    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>
<!--2019-04-01 ebb: Below is an XSLT global variable, which may be used in any template rule. -->
 <xsl:variable name="locations" select="'Forsaken Castle Cainhurst', 'Byrgenwerth', 'Forbidden Woods', 'Hemwick Charnel Lane', 'Cathedral Ward', 'Central Yharnam', 'Old Yharnam', 'Yahar', 'Lecture Building', 'Nightmare of Mensis', 'Nightmare Frontier'"/>
 
<xsl:template match="/">
   <html>
       <head><title>Bloodborne Lore Objects</title>
           <link/><!--ebb: Flesh out your CSS link line here. -->
       </head>
      
       <body>
           <xsl:variable name="rootNode" select="."/>
           <!--ebb: This is a local variable (only applies inside this template rule). We need a variable for the root element of your XML input file, because we'll be moving off the XML tree in the for-each loop below.  -->
           <xsl:for-each select="$locations">
    <h1 id="current()">
        <!--ebb: I set up an xsl:choose to help deal with the apostrophe in the location name of Yahar'Gul, which complicated my storing it in the location variable above. Note that the value of current() is the specific value being processed in the xsl:for-each loop. It's the same thing as the $i range variable in an XQuery for-loop: for $i in $sequence. -->
        <xsl:choose>
            <xsl:when test="current() = 'Yahar'"><xsl:text>Yahar'Gul, Unseen Village</xsl:text>
            </xsl:when>       <xsl:otherwise><xsl:value-of select="current()"/></xsl:otherwise>
        </xsl:choose>
    </h1>
   <!--ebb: I created a local variable for convenience to contain the matching caryllRune element in its entirety. -->           
               <xsl:apply-templates  select="$rootNode//caryllRune[locationArea[contains(normalize-space(.), current())]]"/>
          <!--   <h2><xsl:value-of select="$caryllRune/runeName"/></h2>-->
               
               
           </xsl:for-each>
       </body>
   </html>
</xsl:template>
    
 <xsl:template match="caryllRune">
     <h2><xsl:apply-templates select="runeName"/></h2>
     <h3>Description: </h3>
     <p><xsl:apply-templates select="description/normalize-space(.)"/></p>
     <!--ebb: My structure here is only suggestive, using a sequence of HTML heading elements for size. You could code this however you wish. add more here to output the trivia, notes, etc.  -->
 </xsl:template>   
</xsl:stylesheet>