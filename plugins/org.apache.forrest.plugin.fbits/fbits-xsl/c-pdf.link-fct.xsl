<?xml version="1.0" encoding="UTF-8"?>
<!--
  Copyright 2002-2004 The Apache Software Foundation

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
<forrest:contract name="pdf-fct" nc="pdf" tlc="content"
  xmlns:forrest="http://apache.org/forrest/templates/1.0">
  <description>
    This functions will output the PDF link with image.
  </description>

	<xsl type="xhtml">
    <xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
		  <xsl:template name="pdf-head">
		    <head/>
		  </xsl:template>
		  
		  <xsl:template name="pdf-body">
		    <body>
		      <div id="pdf" title="Portable Document Format"><a href="{$filename-noext}.pdf" class="dida">
		        <img class="skin" src="{$skin-img-dir}/pdfdoc.gif" alt="PDF - icon"/><br/>
		        PDF</a>
		      </div>
		    </body>
		  </xsl:template>
		
		</xsl:stylesheet>
	</xsl>
</forrest:contract>