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
               <!--ebb: Here we are generating a distinct id for each location, by cutting off either the first or the last piece of the name. We have an issue with two places beginning with the word "Nightmare" so we're setting up an xsl:choose to deal with that special case.  -->
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
                   <!--ebb: I set up an xsl:choose below this to help deal with the apostrophe in the location name of Yahar'Gul, which complicated my storing it in the location variable above. Note that the value of current() is the specific value being processed in the xsl:for-each loop. It's the same thing as the $i range variable in an XQuery for-loop: for $i in $sequence. 
      
        -->
                   
      <xsl:choose>
          <xsl:when test="current() = 'yahar'">
              <xsl:text>Yahar'Gul, Unseen Village </xsl:text>
          </xsl:when>
<!--ebb: Below, we process every other location name. Remember, we lower-cased these above in the $locations variable, so with the complex set of functions below, I am tokenizing the location names on white spaces, and upper-casing the first letter of each substring. That will restore the capitalization! You may just want to remove one capitalized word "Of" in your output of h1 elements. -->
          <xsl:otherwise><xsl:value-of select="for $i in tokenize(current(), '\s+') return concat(substring($i, 1, 1) ! upper-case(.), substring($i, 2)) "/>
          </xsl:otherwise>
      </xsl:choose>
    </h1>  
      <section id="caryllRune">
          <h2>Caryll Rune</h2>
     <!--ebb: You might want to create an HTML table here, by setting the table and its header cells at this level. -->
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
        <!--ebb: My structure here is only suggestive, and should be changed to your table structure. You should probably be generating a table row here with table cells to contain the rune name, its description, anything else you want to output at this point. -->
    </xsl:template>   

</xsl:stylesheet>