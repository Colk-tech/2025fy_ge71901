<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" version="4.01" encoding="UTF-8" indent="yes"/>

    <!-- メインテンプレート -->
    <xsl:template match="/">
        <html lang="ja">
            <head>
                <title>
                    <xsl:value-of select="books/metadata/title"/>
                </title>
                <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@400;700&amp;display=swap"
                      rel="stylesheet"/>
                <style type="text/css">
                    body {
                    font-family: 'Noto Sans JP', sans-serif;
                    background-color: #fff;
                    color: #333;
                    margin: 1em;
                    font-size: 13px;
                    line-height: 1.4;
                    max-width: 1000px;
                    margin-left: auto;
                    margin-right: auto;
                    }

                    h1 {
                    font-size: 18px;
                    margin-bottom: 0.5em;
                    color: #2c3e50;
                    border-bottom: 1px solid #ccc;
                    padding-bottom: 0.3em;
                    }

                    div {
                    margin-bottom: 0.4em;
                    }

                    table {
                    width: 100%;
                    border-collapse: collapse;
                    background-color: #fafafa;
                    border: 1px solid #ccc;
                    table-layout: fixed;
                    }

                    thead {
                    background-color: #2c3e50;
                    color: #fff;
                    }

                    th, td {
                    padding: 4px 6px;
                    text-align: left;
                    border: 1px solid #ccc;
                    word-wrap: break-word;
                    font-size: 12px;
                    }

                    a {
                    color: #2980b9;
                    text-decoration: none;
                    }

                    a:hover {
                    text-decoration: underline;
                    }

                    tbody tr:hover {
                    background-color: #eef1f5;
                    }
                </style>
            </head>
            <body>
                <h1>
                    <xsl:value-of select="books/metadata/title"/>
                </h1>
                <div>作成日：<xsl:value-of select="books/metadata/date_created"/>
                </div>
                <div><xsl:value-of select="count(books/item)"/>件のメタデータ
                </div>

                <br/>

                <table border="1">
                    <thead>
                        <tr>
                            <th>Item No.</th>
                            <th>Title</th>
                            <th>Creator</th>
                            <th>Publisher</th>
                            <th>Description</th>
                            <th>Price (JPY)</th>
                            <th>Publication Date</th>
                            <th>ISBN</th>
                            <th>Keywords</th>
                            <th>URL</th>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each select="books/item">
                            <tr>
                                <td>
                                    <!-- @<attribute> で属性を取得できる -->
                                    <xsl:value-of select="@no"/>
                                </td>
                                <td>
                                    <xsl:value-of select="title"/>
                                </td>
                                <td>
                                    <xsl:value-of select="creator"/>
                                </td>
                                <td>
                                    <xsl:value-of select="publisher"/>
                                </td>
                                <td>
                                    <xsl:value-of select="description"/>
                                </td>
                                <td>
                                    <xsl:value-of select="price"/>
                                </td>
                                <td>
                                    <!--
                                     concat() を用いることで、テキストを結合できる
                                     加えて、format-number() を用いることで、数字を正規化できる
                                     -->
                                    <xsl:value-of
                                            select="concat(date/year, '-', format-number(date/month, '00'), '-', format-number(date/day, '00'))"/>
                                </td>
                                <td>
                                    <xsl:value-of select="isbn"/>
                                </td>
                                <td>
                                    <!--
                                     for-each を用いることで、要素を繰り返し処理できる
                                     さらに、xsl:if を用いて、position() が last() でなければ ", " を表示させている
                                     -->
                                    <xsl:for-each select="keywords/keyword">
                                        <xsl:value-of select="."/>
                                        <xsl:if test="position() != last()">,</xsl:if>
                                    </xsl:for-each>
                                </td>
                                <td>
                                    <a>
                                        <!-- xsl:attribute で属性を追加できる -->
                                        <xsl:attribute name="href">
                                            <xsl:value-of select="url/@resource"/>
                                        </xsl:attribute>
                                        リンク
                                    </a>
                                </td>
                            </tr>
                        </xsl:for-each>
                    </tbody>
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
