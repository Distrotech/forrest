<?xml version="1.0"?>
<!--
  Copyright 1999-2005 The Apache Software Foundation or its licensors,
  as applicable.

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
-->

<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:lex="http://chaperon.sourceforge.net/schema/lexemes/2.0">

 <xsl:template match="lex:lexeme[@symbol='link']">
   <xsl:choose>
  <!-- it is possible to disable link writing by prefixing by '\' -->
    <xsl:when test="not( starts-with( @text, '\') )">
      <a href="{@text}">
       <xsl:value-of select="@text"/>
      </a>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="lex:group[2]"/>
    </xsl:otherwise>
  </xsl:choose>

 </xsl:template>

 <xsl:template match="lex:lexeme[@symbol='email']">
  <xsl:choose>
  <!-- it is possible to disable link writing by prefixing by '\' -->
    <xsl:when test="not( starts-with( @text, '\') )">
      <a href="mailto:{@text}">
        <xsl:value-of select="lex:group[2]"/> at <xsl:value-of select="lex:group[3]"/>
      </a>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="lex:group[2]"/>@<xsl:value-of select="lex:group[3]"/>
    </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <xsl:template match="lex:lexeme[@symbol='cssurl']">
    <a href="{lex:group[3]}"><xsl:value-of select="lex:group[1]"/></a>
 </xsl:template>
 
 <xsl:template match="@*|*|text()|processing-instruction()" priority="-1">
  <xsl:copy>
   <xsl:apply-templates select="@*|*|text()|processing-instruction()"/>
  </xsl:copy>
 </xsl:template>

</xsl:stylesheet>
