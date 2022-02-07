<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username') displayInfo=(realm.password && realm.registrationAllowed && !registrationDisabled??); section>
    <#if section = "header">
      <div id="kc-header" class="${properties.kcHeaderClass!}">
        <div id="kc-header-wrapper"
          class="${properties.kcHeaderWrapperClass!}">${kcSanitize(msg("loginTitleHtml",(realm.displayNameHtml!'')))?no_esc}
        </div>
      </div>
      <!-- ${msg("loginAccountTitle")} -->
    <#elseif section = "form">
        <div id="kc-form" class="kc-form-wrapper-login">
            <div id="kc-form-wrapper">
              <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
                <div id="kc-registration-container">
                  <div id="kc-registration">
                    <div class="kc-tabs">
                      <div class="kc-tab kc-tab-active">
                        Login
                      </div>
                      <a class="kc-tab" tabindex="6" href="${url.registrationUrl}">${msg("doRegister")}</a>
                    </div>
                  </div>
                </div>
              </#if>
              <div class="kc-form-body">
                <#if realm.password && social.providers??>
                  <div id="kc-social-providers" class="${properties.kcFormSocialAccountSectionClass!}">
                      <ul class="${properties.kcFormSocialAccountListClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountListGridClass!}</#if>">
                          <#list social.providers as p>
                              <a id="social-${p.alias}" class="${properties.kcFormSocialAccountListButtonClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountGridItem!}</#if>"
                                type="button" href="${p.loginUrl}">
                                  <#if p.iconClasses?has_content>
                                      <i class="${properties.kcCommonLogoIdP!} ${p.iconClasses!}" aria-hidden="true"></i>
                                      <span class="${properties.kcFormSocialAccountNameClass!} kc-social-icon-text">${p.displayName}</span>
                                  <#else>
                                      <span class="${properties.kcFormSocialAccountNameClass!}">${p.displayName}</span>
                                  </#if>
                              </a>
                          </#list>
                      </ul>
                      <h4 class="kc-or-msg">${msg("identity-provider-login-label")}</h4>
                  </div>
              </#if>
            </div>

            <#if realm.password>
                <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
                    <div class="kc-form-body">
                      <#if !usernameHidden??>
                          <div class="${properties.kcFormGroupClass!}">
                              <label for="username"
                                      class="${properties.kcLabelClass!}"><#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if></label>

                              <input tabindex="1" id="username"
                                      aria-invalid="<#if messagesPerField.existsError('username')>true</#if>"
                                      class="${properties.kcInputClass!}" name="username"
                                      value="${(login.username!'')}"
                                      type="text" autofocus autocomplete="off"/>

                              <#if messagesPerField.existsError('username')>
                                  <span id="input-error-username" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                      ${kcSanitize(messagesPerField.get('username'))?no_esc}
                                  </span>
                              </#if>
                          </div>
                      </#if>
                    

                      <div class="${properties.kcFormGroupClass!} ${properties.kcFormSettingClass!}">
                          <div id="kc-form-options">
                              <#if realm.rememberMe && !usernameHidden??>
                                  <div class="checkbox">
                                      <label>
                                          <#if login.rememberMe??>
                                              <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox"
                                                      checked> ${msg("rememberMe")}
                                          <#else>
                                              <input tabindex="3" id="rememberMe" name="rememberMe"
                                                      type="checkbox"> ${msg("rememberMe")}
                                          </#if>
                                      </label>
                                  </div>
                              </#if>
                          </div>
                      </div>

                    </div>

                    <div id="kc-form-buttons" class="kc-form-foot ${properties.kcFormGroupClass!}">
                        <input tabindex="4"
                          class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}"
                          name="login" id="kc-login" type="submit" value="${msg("doLogIn")}"/>
                    </div>
                </form>
            </#if>
        </div>
    </div>
  </#if>

</@layout.registrationLayout>