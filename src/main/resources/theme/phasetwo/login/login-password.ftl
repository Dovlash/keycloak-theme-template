<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('password'); section>
    <#if section = "header">
      <div id="kc-header" class="${properties.kcHeaderClass!}">
        <div id="kc-header-wrapper"
          class="${properties.kcHeaderWrapperClass!}">${kcSanitize(msg("loginTitleHtml",(realm.displayNameHtml!'')))?no_esc}
        </div>
      </div>
      <!-- ${msg("doLogIn")} -->
    <#elseif section = "form">
      <div id="kc-form">
        <div id="kc-form-wrapper">
          <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
            <div class="kc-form-body">
              <div class="${properties.kcFormGroupClass!} no-bottom-margin">
                <label for="password" class="${properties.kcLabelClass!}">${msg("password")}</label>
                <input tabindex="2" id="password" class="${properties.kcInputClass!}" name="password"
                        type="password" autocomplete="on"
                        aria-invalid="<#if messagesPerField.existsError('password')>true</#if>"
                />
                <#if messagesPerField.existsError('password')>
                    <span id="input-error-password" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                        ${kcSanitize(messagesPerField.get('password'))?no_esc}
                    </span>
                </#if>
              </div>

              <div class="${properties.kcFormGroupClass!} ${properties.kcFormSettingClass!}">
                  <div id="kc-form-options" class="kc-form-options-pass">
                    <div class="${properties.kcFormOptionsWrapperClass!}">
                      <#if realm.resetPasswordAllowed>
                          <span><a tabindex="5" href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a></span>
                      </#if>
                    </div>
                  </div>
              </div>
            </div>

            <div class="kc-form-foot">
              <div id="kc-form-buttons" class="${properties.kcFormGroupClass!}">
                <input tabindex="4" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" name="login" id="kc-login" type="submit" value="${msg("doLogIn")}"/>
              </div>
            </div>
          </form>
      </div>
    </div>
  </#if>

</@layout.registrationLayout>