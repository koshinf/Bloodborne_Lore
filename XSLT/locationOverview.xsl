<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    exclude-result-prefixes="xs math"
    xmlns:exslt="http://exslt.org/common"
    xmlns="http://www.w3.org/1999/xhtml"
    version="3.0">
    
    <xsl:output method="xhtml" encoding="utf-8" doctype-system="about:legacy-compat"
        omit-xml-declaration="yes"/>
    
    <xsl:param name="pQString" as="xs:string" select="'?id=Cathedral_Ward'"/>
    
    <!-- Above we have our Param variable. I will figure out how to run XSLT clientside,
         but if I don't, we can still generate pages by plugging IDs in.
         Just type in a location id to test it!-->
    
    <xsl:variable name="locationID" as="xs:string" select="substring-after($pQString,'=')"/>
    
    <!-- below is a variable storing the location title. I'm lazy and this gets used alot, so I'd prefer to just type in a var name -->
    
    <xsl:variable name="locationTitle" as="xs:string" select="string-join(tokenize($locationID, '_'),' ')"/>
    
    <!-- DEFINE KEYS -->
    
    <xsl:key name="currentNPC" match="npc" use="locationArea/location/@place"/>
    
    <xsl:key name="currentBoss" match="boss" use="locationArea/location/@place"/>
    
    <xsl:key name="currentRune" match="caryllRune" use="locationArea/location/@place"/>
    
    <xsl:key name="currentAttire" match="attire" use="locationArea/location/@place"/>
    
    <xsl:key name="currentWeapon" match="weapon" use="locationArea/location/@place"/>
    
    <xsl:key name="currentFirearm" match="firearm" use="locationArea/location/@place"/>
    
    <!-- BEGIN TEMPLATE -->
    
    <xsl:template match="/">
        
        <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <title><xsl:value-of select="$locationTitle"/></title>
                <meta charset="UTF-8" />
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                <link rel="stylesheet" type="text/css" href="css/main.css"/>
                    <link rel="icon" type="image/png" href="images/favicon.jpg"/>
                        <style>
                            * {
                            box-sizing: border-box;
                            }
                        </style>

            </head>
            
            <body>
                <ul id="nav">
                    <li class="navButton"><a href="index.html" class="active">Home</a></li>
                    <li class="navButton"><a href="aboutGame.html">About Game</a></li>
                    <li class="navButton"><a href="team.html">The Team</a></li>
                    <li class="navButton"><a href="results.html">Results</a></li>
                </ul>
                <div class="header">
                    <img class ="header-img" src="images/banner.jpg"/>
                </div>
                
                <!-- Start actual page -->
                <div class="dataDataContainer" style="margin-top: 2em;">
                    <div class="d">
                        
                        <div class="dataLoc"><xsl:value-of select="$locationTitle"/></div>
                        
                        <div class="loreType"> <p> Caryll Rune</p> </div>
                        
                            <xsl:apply-templates select="key('currentRune',$locationID)" mode="dataBlock"/>
                        
                        <div class="loreType"> <p>Attire</p> </div>
                        
                            <xsl:apply-templates select="key('currentAttire',$locationID)" mode="dataBlock"/>
                        
                        <div class="loreType"> <p>Weapon</p> </div>
                        
                            <xsl:apply-templates select="key('currentWeapon',$locationID)" mode="dataBlock"/>
                        
                        <div class="loreType"> <p>Firearm</p> </div>
                        
                            <xsl:apply-templates select="key('currentFirearm',$locationID)" mode="dataBlock"/>
                        
                        <div class="loreType"> <p>Item</p> </div>
                        
                            <!-- No item XML! -->
                        
                        <div class="loreType"> <p>Area</p> </div>
                        
                            <!-- No area XML!-->
                        
                        <div class="loreType"> <p>NPC</p> </div>
                        
                            <xsl:apply-templates select="key('currentNPC',$locationID)" mode="dataBlock"/>
                        
                        <div class="loreType"> <p>Boss</p> </div>
                        
                            <xsl:apply-templates select="key('currentBoss',$locationID)" mode="dataBlock"/>
                        
                    </div>
                </div>
                
            </body>
            
        </html>   
        
    </xsl:template>
    
    <!-- DATA BLOCK TEMPLATES -->
    
    <xsl:template match="key('currentRune',$locationID)" mode="dataBlock">
        
        <div class="dataCont"><!-- Data Container -->
            <div class="data"><p><strong><xsl:apply-templates select="string-join(tokenize(runeName/@runeList, '_'),' ')"/></strong></p></div>
            <div class="data"><!-- Data Location -->
                <p><strong>Location: </strong><xsl:value-of select="$locationTitle"/></p>
            </div>
            <!-- If none leave empty -->
            <div class="data"><!-- Data Description -->
                <p><strong>Description:</strong><xsl:apply-templates select="description"/>
                     </p>
                <p><strong>Effect:</strong> <xsl:apply-templates select="effect"/> </p>
                
                <p><strong>Notes:</strong> <xsl:apply-templates select="notes" mode="notes"/> </p>
                <p><strong>Trivia:</strong> <xsl:apply-templates select="trivia"/> </p>
            </div>
        </div>
        
    </xsl:template>
    
    <xsl:template match="key('currentAttire',$locationID)" mode="dataBlock">
        
        <div class="dataCont"><!-- Data Container -->
            <div class="data"><p><strong><xsl:apply-templates select="string-join(tokenize(attireName/@attireList, '_'),' ')"/></strong></p></div>
            <div class="data"><!-- Data Location -->
                <p><strong>Location: </strong> <xsl:value-of select="$locationTitle"/></p>
            </div>
            <!-- If none leave empty -->
            <div class="data"><!-- Data Description -->
                <p><strong>Set:</strong><xsl:apply-templates select="attireName/@attireSet"/>
                </p>
                <p><strong>Description:</strong><xsl:apply-templates select="description"/>
                </p>
                <p><strong>Effect:</strong> <xsl:apply-templates select="effect"/> </p>
                
                <p><strong>Notes:</strong> <xsl:apply-templates select="notes" mode="notes"/> </p>
                <p><strong>Trivia:</strong> <xsl:apply-templates select="trivia"/> </p>
            </div>
        </div>
        
    </xsl:template>
    
    <xsl:template match="key('currentWeapon',$locationID)" mode="dataBlock">
        
        <div class="dataCont"><!-- Data Container -->
            <div class="data"><p><strong><xsl:apply-templates select="string-join(tokenize(weaponName/@weaponList, '_'),' ')"/></strong></p></div>
            <div class="data"><!-- Data Location -->
                <p><strong>Location: </strong> <xsl:value-of select="$locationTitle"/></p>
            </div>
            <!-- If none leave empty -->
            <div class="data"><!-- Data Description -->
                <p><strong>Description:</strong><xsl:apply-templates select="description"/>
                </p>
                <p><strong>Effect:</strong> <xsl:apply-templates select="effect"/> </p>
                
                <p><strong>Notes:</strong> <xsl:apply-templates select="notes" mode="notes"/> </p>
                <p><strong>Trivia:</strong> <xsl:apply-templates select="trivia"/> </p>
            </div>
        </div>
        
    </xsl:template>
    
    <xsl:template match="key('currentFirearm',$locationID)" mode="dataBlock">
        
        <div class="dataCont"><!-- Data Container -->
            <div class="data"><p><strong><xsl:apply-templates select="string-join(tokenize(firearmName/@firearmList, '_'),' ')"/></strong></p></div>
            <div class="data"><!-- Data Location -->
                <p><strong>Location: </strong> <xsl:value-of select="$locationTitle"/></p>
            </div>
            <!-- If none leave empty -->
            <div class="data"><!-- Data Description -->
                <p><strong>Description:</strong><xsl:apply-templates select="description"/>
                </p>
                <p><strong>Effect:</strong> <xsl:apply-templates select="effect"/> </p>
                
                <p><strong>Notes:</strong> <xsl:apply-templates select="notes" mode="notes"/> </p>
                <p><strong>Trivia:</strong> <xsl:apply-templates select="trivia"/> </p>
            </div>
        </div>
        
    </xsl:template>
    
    <!--<xsl:template match="key('currentItem',$locationID)" mode="dataBlock"></xsl:template>-->
    
    <!--<xsl:template match="key('currentArea',$locationID)" mode="dataBlock"></xsl:template>-->
    
    <xsl:template match="key('currentNPC',$locationID)" mode="dataBlock">
        
        <div class="dataCont"><!-- Data Container -->
            <div class="data"><p><strong><xsl:apply-templates select="string-join(tokenize(npcName/@npcList, '_'),' ')"/></strong></p></div>
            <div class="data"><!-- Data Location -->
                <p><strong>Location: </strong> <xsl:value-of select="$locationTitle"/></p>
                <p><strong>Description:</strong><xsl:apply-templates select="description"/>
                </p>
                
                <p><strong>Notes:</strong> <xsl:apply-templates select="notes" mode="notes"/> </p>
            </div>
            <!-- If none leave empty -->
            <div class="data"><!-- Data Description -->
                
                <p><strong>Dialogue:</strong> <xsl:apply-templates select="dialogue" mode="quotations"/> </p>
            </div>
        </div>
        
    </xsl:template>
    
    <xsl:template match="key('currentBoss',$locationID)" mode="dataBlock">
        
        <div class="dataCont"><!-- Data Container -->
            <div class="data"><p><strong><xsl:apply-templates select="string-join(tokenize(bossName/@bossList, '_'),' ')"/></strong></p></div>
            <div class="data"><!-- Data Location -->
                <p><strong>Location: </strong> <xsl:value-of select="$locationTitle"/></p>
                <p><strong>Description:</strong><xsl:apply-templates select="description"/>
                </p>
                
                <p><strong>Notes:</strong> <xsl:apply-templates select="notes" mode="notes"/> </p>
            </div>
            <!-- If none leave empty -->
            <div class="data"><!-- Data Description -->
                
                <p><strong>Dialogue:</strong> <xsl:apply-templates select="dialogue" mode="quotations"/> </p>
            </div>
        </div>
        
    </xsl:template>
    
    <xsl:template match="dialogue/line" mode="quotations">
        
        <xsl:variable name="tokens" select=" tokenize(./text(),'\n\r?')"/>
        
        <xsl:for-each select="$tokens">
            
            <p>
                
                <i><xsl:sequence select="."/></i>
                
            </p>
        </xsl:for-each>
        
        
        
    </xsl:template>
    
    <xsl:template match="notes" mode="notes">
        
        <xsl:variable name="tokens" select=" tokenize(./text(),'\n\r?')"/>
        
        <xsl:for-each select="$tokens">
            
            <p>
                
                <xsl:sequence select="."/>
                
            </p>
        </xsl:for-each>
        
        
        
    </xsl:template>
    
</xsl:stylesheet>