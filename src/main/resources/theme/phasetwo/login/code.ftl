<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
<h1>Yo sir</h1>
    <#if section = "header">
        <#if code.success>
            ${msg("codeSuccessTitle")}
        <#else>
            ${msg("codeErrorTitle", code.error)}
        </#if>
    <#elseif section = "form">
    
        <div id="kc-code">
            <#if code.success>
                <p>${msg("copyCodeInstruction")}</p>
                <input id="code" class="${properties.kcTextareaClass!}" value="${code.code}"/>
            <#else>
                <p id="error">${code.error}</p>
            </#if>
        </div>
    </#if>
</@layout.registrationLayout>