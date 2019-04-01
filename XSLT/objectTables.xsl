<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="3.0">

    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>
<!--2019-04-01 ebb: Below is an XSLT global variable, which may be used in any template rule. -->
 <xsl:variable name="locations" select="'forsaken castle cainhurst', 'byrgenwerth', 'forbidden woods', 'hemwick charnel lane', 'cathedral ward', 'central yharnam', 'old yharnam', 'yahar', 'lecture building', 'nightmare of mensis', 'nightmare frontier'"/>
 
<xsl:template match="/">
   <html>
       <head><title>Bloodborne Lore Objects</title>
           <link/><!--ebb: Flesh out your CSS link line here. -->
       </head>
      
       <body>
           <xsl:variable name="rootNode" select="."/>
           <!--ebb: This is a local variable (only applies inside this template rule). We need a variable for the root element of your XML input file, because we'll be moving off the XML tree in the for-each loop below.  -->
           <xsl:for-each select="$locations">
    <xsl:variable name="locId">
        <xsl:choose>
            <xsl:when test="contains(current(), 'nightmare')">
                <xsl:value-of select="tokenize(current(), '\s+')[last()]"/>
                
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="tokenize(current(), '\s+')[1]"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>
         <div id="div_{$locId}">      
               <h1 id="{$locId}">
        <!--ebb: I set up an xsl:choose to help deal with the apostrophe in the location name of Yahar'Gul, which complicated my storing it in the location variable above. Note that the value of current() is the specific value being processed in the xsl:for-each loop. It's the same thing as the $i range variable in an XQuery for-loop: for $i in $sequence. 
        Note: I wasn't crazy about using the entire name with white spaces in this @id, but it can work as a link target from your map to this portion of the page. I tinkered a bit with tokenize() and just cut off the name before the first space character; to my surprise the tokenize function with [1] (taking the first cut) before a \s+ did a cut on the apostrophe in Yahar'Gul (yay! thanks XPath specs. ). 
        -->
        <xsl:value-of select="current()"/>
    </h1>  
      <section id="caryllRune">
          <h2>Caryll Rune</h2>
     
               <xsl:apply-templates  select="$rootNode//caryllRune[locationArea[contains(. ! lower-case(.) ! normalize-space(.), current())]]"/>
      </section>
      <section id="Attire">
          <h2>Attire</h2>
          
          
          
          
      </section>         
      <section id="Weapon">
          <h2>Weapon</h2>
          
          
      </section>         
       <section id="Firearm">
        <h2>Weapon</h2>
                   
                   
      </section>
       <section id="Item">
         <h2>Item</h2>
                   
                   
     </section>  
    <section id="Item">
       <h2>Area</h2>
                   
    </section>  
   <section id="NPC">
      <h2>NPC</h2>
                   
    </section>                
     <section id="Boss">
         <h2>Boss</h2>
                   
     </section>                
  </div>     
           </xsl:for-each>
           
       </body>
   </html>
</xsl:template>
    
    <xsl:template match="caryllRune">
 <!--ebb: Because we PRUNED THE TREE up in the template match on the document node, ONLY the caryllRunes that we selected there will be processed here. -->
        <h2><xsl:apply-templates select="runeName"/></h2>
        <h3>Description: </h3>
        <p><xsl:apply-templates select="description/normalize-space(.)"/></p>
        <!--ebb: My structure here is only suggestive, using a sequence of HTML heading elements for size. You could code this however you wish. add more here to output the trivia, notes, etc.  -->
    </xsl:template>   

</xsl:stylesheet>