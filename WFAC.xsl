<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:template match="/">
        <html>
            <head>
                <title>
                    World Outdoor Flint Archery Mail Match
                </title>
            </head>
            <body>
                <h1>Wolds Outdoor Flint Archery Mail Match</h1>
                <h1>Inhaltsverzeichnis</h1>
                
               
                <xsl:apply-templates select="//group" mode="toc"></xsl:apply-templates>
                <xsl:apply-templates select="//group" mode="detail"></xsl:apply-templates>
               
                <h1>
                    Scorecards
                </h1>
                
               <xsl:apply-templates select="//groupmember" mode="scc"></xsl:apply-templates>
                
                <h2>
                    <xsl:apply-templates select="wfac2020/round/group/groupmember" mode="scc"></xsl:apply-templates>
                </h2>
            </body>
        </html>
    </xsl:template>
    
    
    <xsl:template match="group" mode="toc">
        <a href="{generate-id()}">
            <div>
                Group
                <xsl:variable name="gid" select="@group-id"/><xsl:value-of select="substring-after($gid, 'g')"/> -
                <xsl:value-of select="date"/>
            </div>
  
        </a>
    </xsl:template>
    
    
    
    
    
    
    <xsl:template match="group" mode="detail">
        <h1 xml:space="preserve">
            <xsl:value-of select="position()"/>. Day,
            <xsl:value-of select="date"/>
        </h1>
        
        
        
        <h2>
            <xsl:value-of select="position()"/>. Day, scoring
        </h2>
        <xsl:value-of select="group"/>
        <h2>Group
                <xsl:variable name="gid" select="@group-id"/>
                <xsl:value-of select="substring-after($gid, 'g')"/>
        </h2>
        
        <xsl:for-each xml:space="preserve" select="groupmember"><br/>
            <xsl:variable name ="id" select="@competitor-id"/>
            <xsl:variable name="firstname" select="//competitor[@id = $id]/firstname"/>
            <xsl:variable name="lastname" select="//competitor[@id = $id]/lastname"/>
            <xsl:value-of select="concat($firstname, ' ', $lastname)"/>
            <a href="#{generate-id()}">(<xsl:value-of select="sum(score-card/target/arrow[./text()>0])"/>)</a>
        </xsl:for-each>
        
        
    </xsl:template>
    
    
     <xsl:template match="groupmember" mode="scc">
         <xsl:variable name ="id" select="@competitor-id"/>
         <xsl:variable name="firstname" select="//competitor[@id = $id]/firstname"/>
         <xsl:variable name="lastname" select="//competitor[@id = $id]/lastname"/>
         <xsl:variable name="gid" select="../@group-id"/>
         <xsl:variable name="gdate" select="../date"/>
            <h3 id="{generate-id()}"><xsl:value-of select="id(@competitor-id)/concat($firstname, ' ', $lastname, ' - Group ', substring-after($gid, 'g'), ' ',$gdate)"/></h3>
            
            
            <table border = "2">
                <tr>
                    <th>target#</th>
                    <th>arrow 1</th>
                    <th>arrow 2</th>
                    <th>arrow 3</th>
                    <th>arrow 4</th>
                </tr>
                <xsl:for-each select="score-card">
                    <xsl:for-each select="target">
                        <tr>
                            <td>
                                <xsl:value-of select="position()"/>
                            </td>
                            <xsl:for-each select="arrow">
                                
                                <td>
                                    <xsl:value-of select="."></xsl:value-of>
                                </td>
                            </xsl:for-each>
                            
                         
                            
                        </tr>
                    </xsl:for-each>
                </xsl:for-each>
                
            </table>
            
        </xsl:template>
        

 

</xsl:stylesheet>