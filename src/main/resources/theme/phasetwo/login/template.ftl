<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayRequiredFields=false showAnotherWayIfPresent=true>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" class="${properties.kcHtmlClass!}">

<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="robots" content="noindex, nofollow">

    <#if properties.meta?has_content>
        <#list properties.meta?split(' ') as meta>
            <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}"/>
        </#list>
    </#if>
    <title>${msg("loginTitle",(realm.displayName!''))}</title>
    <link rel="icon" href="${url.resourcesPath}/img/favicon.ico" />
    <#if properties.stylesCommon?has_content>
        <#list properties.stylesCommon?split(' ') as style>
            <link href="${url.resourcesCommonPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <#if properties.styles?has_content>
        <#list properties.styles?split(' ') as style>
            <link href="${url.resourcesPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <#if properties.scripts?has_content>
        <#list properties.scripts?split(' ') as script>
            <script src="${url.resourcesPath}/${script}" type="text/javascript"></script>
        </#list>
    </#if>
    <#if scripts??>
        <#list scripts as script>
            <script src="${script}" type="text/javascript"></script>
        </#list>
    </#if>
</head>

<body class="${properties.kcBodyClass!}">
<div class="${properties.kcLoginClass!}">

    <!--
    <div id="kc-header" class="${properties.kcHeaderClass!}">
      <p>This is my template</p>
    </div> 
    -->
    <div class="${properties.kcFormCardClass!}">
        <header class="${properties.kcFormHeaderClass!}">
            <#if realm.internationalizationEnabled  && locale.supported?size gt 1>
                <div class="${properties.kcLocaleMainClass!}" id="kc-locale">
                    <div id="kc-locale-wrapper" class="${properties.kcLocaleWrapperClass!}">
                        <div id="kc-locale-dropdown" class="${properties.kcLocaleDropDownClass!}">
                            <a href="#" id="kc-current-locale-link">${locale.current}</a>
                            <ul class="${properties.kcLocaleListClass!}">
                                <#list locale.supported as l>
                                    <li class="${properties.kcLocaleListItemClass!}">
                                        <a class="${properties.kcLocaleItemClass!}" href="${l.url}">${l.label}</a>
                                    </li>
                                </#list>
                            </ul>
                        </div>
                    </div>
                </div>
            </#if>
        <#if !(auth?has_content && auth.showUsername() && !auth.showResetCredentials())>
            <#if displayRequiredFields>
                <div class="${properties.kcContentWrapperClass!}">
                    <div class="${properties.kcLabelWrapperClass!} subtitle">
                        <span class="subtitle"><span class="required">*</span> ${msg("requiredFields")}</span>
                    </div>
                    <div class="col-md-10">
                        <!-- 
                        <h1 id="kc-page-title"><#nested "header"></h1> 
                        -->
                    </div>
                </div>
            <#else>
              <div id="login-pf-logo"
                  class="${properties.kcHeaderWrapperClass!}">${kcSanitize(msg("loginTitleHtml",(realm.displayNameHtml!'')))?no_esc}</div>
                <!-- <h1 id="kc-page-title"><#nested "header"></h1> -->
            </#if>
        <#else>
            <#if displayRequiredFields>
                <div class="${properties.kcContentWrapperClass!}">
                    <div class="${properties.kcLabelWrapperClass!} subtitle">
                        <span class="subtitle"><span class="required">*</span> ${msg("requiredFields")}</span>
                    </div>
                    <div class="col-md-10">
                        <#nested "show-username">
                        <div id="kc-username" class="${properties.kcFormGroupClass!}">
                            <label id="kc-attempted-username">${auth.attemptedUsername}</label>
                            <a id="reset-login" href="${url.loginRestartFlowUrl}">
                                <div class="kc-login-tooltip">
                                    <i class="${properties.kcResetFlowIcon!}"></i>
                                    <span class="kc-tooltip-text">${msg("restartLoginTooltip")}</span>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
            <#else>
                <#nested "show-username">
                <div id="kc-username" class="${properties.kcFormGroupClass!}">
                    <label id="kc-attempted-username">${auth.attemptedUsername}</label>
                    <a id="reset-login" href="${url.loginRestartFlowUrl}">
                        <div class="kc-login-tooltip">
                            <i class="${properties.kcResetFlowIcon!}"></i>
                            <span class="kc-tooltip-text">${msg("restartLoginTooltip")}</span>
                        </div>
                    </a>
                </div>
            </#if>
        </#if>
      </header>
      <div id="kc-content">
        <div id="kc-content-wrapper">

          <#-- App-initiated actions should not see warning messages about the need to complete the action -->
          <#-- during login.                                                                               -->
          <#if displayMessage && message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
              <div class="alert-${message.type} ${properties.kcAlertClass!} pf-m-<#if message.type = 'error'>danger<#else>${message.type}</#if>">
                  <div class="pf-c-alert__icon">
                      <#if message.type = 'success'><span class="${properties.kcFeedbackSuccessIcon!}"></span></#if>
                      <#if message.type = 'warning'><span class="${properties.kcFeedbackWarningIcon!}"></span></#if>
                      <#if message.type = 'error'><span class="${properties.kcFeedbackErrorIcon!}"></span></#if>
                      <#if message.type = 'info'><span class="${properties.kcFeedbackInfoIcon!}"></span></#if>
                  </div>
                      <span class="${properties.kcAlertTitleClass!}">${kcSanitize(message.summary)?no_esc}</span>
              </div>
          </#if>

          <#nested "form">

            <#if auth?has_content && auth.showTryAnotherWayLink() && showAnotherWayIfPresent>
                <form id="kc-select-try-another-way-form" action="${url.loginAction}" method="post">
                    <div class="${properties.kcFormGroupClass!}">
                        <input type="hidden" name="tryAnotherWay" value="on"/>
                        <a href="#" id="try-another-way"
                           onclick="document.forms['kc-select-try-another-way-form'].submit();return false;">${msg("doTryAnotherWay")}</a>
                    </div>
                </form>
            </#if>

          <#if displayInfo>
              <div id="kc-info" class="${properties.kcSignUpClass!}">
                  <div id="kc-info-wrapper" class="${properties.kcInfoAreaWrapperClass!}">
                      <#nested "info">
                  </div>
              </div>
          </#if>
        </div>
        <h1>Powered</h1>
        <div class="kc-powered">
          <svg width="85px" height="9px" viewBox="0 0 85 9" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
              <g id="v1" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                  <g id="login6" transform="translate(-775.000000, -619.000000)">
                      <rect id="Rectangle" fill="#3C474E" opacity="0.800000012" x="0" y="0" width="1400" height="808"></rect>
                      <g id="Group-2-Copy" transform="translate(775.000000, 619.000000)" fill="#FFFFFF" opacity="0.400000006">
                          <g id="Group-18-Copy-4" transform="translate(49.000000, 0.000000)">
                              <path d="M1.24752147,2.05362699 L1.24752147,2.60091534 C1.47257669,2.37873129 1.71640491,2.20999509 1.97922699,2.09890307 C2.24160736,1.9880319 2.5229816,1.93171288 2.82158282,1.93171288 C3.47046626,1.93171288 4.02217178,2.17708712 4.4771411,2.66628957 C4.93211043,3.1572589 5.15871166,3.78560245 5.15871166,4.55330798 C5.15871166,5.29274356 4.92415951,5.91181104 4.45373006,6.40874356 C3.98484663,6.90744294 3.42828221,7.15613006 2.78425767,7.15613006 C2.49802454,7.15613006 2.23078528,7.10444908 1.98364417,7.00285399 C1.73672393,6.9012589 1.49134969,6.73406871 1.24752147,6.50106258 L1.24752147,8.85387239 L0.000110429448,8.85387239 L0.000110429448,2.05362699 L1.24752147,2.05362699 Z M2.55743558,3.07598282 C2.16496933,3.07598282 1.83831902,3.21048589 1.58035583,3.47772515 C1.32106748,3.74673129 1.19120245,4.09679264 1.19120245,4.52967607 C1.19120245,4.9722773 1.32106748,5.33006871 1.58035583,5.60216687 C1.83831902,5.87581104 2.16496933,6.01163926 2.55743558,6.01163926 C2.9388589,6.01163926 3.25932515,5.87271902 3.52060123,5.59598282 C3.78143558,5.31770061 3.91130061,4.96432638 3.91130061,4.53453497 C3.91130061,4.10761472 3.7829816,3.75755337 3.52678528,3.48545521 C3.27191411,3.2120319 2.94835583,3.07598282 2.55743558,3.07598282 L2.55743558,3.07598282 Z" id="Fill-1"></path>
                              <path d="M5.86561472,0.130829448 L7.11302577,0.130829448 L7.11302577,2.56314847 C7.35685399,2.35222822 7.60090307,2.19431411 7.84782331,2.08962699 C8.09319755,1.98493988 8.34343067,1.93171288 8.59498896,1.93171288 C9.08750429,1.93171288 9.5033816,2.10199509 9.84107485,2.44454724 C10.1301791,2.73983558 10.2739583,3.17448589 10.2739583,3.74673129 L10.2739583,7.03421595 L9.04532025,7.03421595 L9.04532025,4.85345521 C9.04532025,4.27811779 9.01881718,3.88719755 8.96404417,3.68400736 C8.90927117,3.47927117 8.81540613,3.32776196 8.68266994,3.22594601 C8.5512589,3.12611779 8.38716074,3.07598282 8.19346748,3.07598282 C7.94168834,3.07598282 7.72436319,3.16035092 7.54303804,3.32776196 C7.3632589,3.49495215 7.23825276,3.72309939 7.16779877,4.01242454 C7.13179877,4.16238773 7.11302577,4.50317301 7.11302577,5.03632638 L7.11302577,7.03421595 L5.86561472,7.03421595 L5.86561472,0.130829448 Z" id="Fill-4"></path>
                              <path d="M14.8359534,2.05362699 L16.0833644,2.05362699 L16.0833644,7.03421595 L14.8359534,7.03421595 L14.8359534,6.5041546 C14.5921252,6.73561472 14.3465301,6.9012589 14.1011558,7.00285399 C13.8557816,7.10444908 13.5885423,7.15613006 13.3023092,7.15613006 C12.6567387,7.15613006 12.1001742,6.90744294 11.6297448,6.40874356 C11.1590945,5.91181104 10.9247632,5.29274356 10.9247632,4.55330798 C10.9247632,3.78560245 11.1529104,3.1572589 11.6076589,2.66628957 C12.0626282,2.17708712 12.6145546,1.93171288 13.2647632,1.93171288 C13.5649104,1.93171288 13.8447387,1.9880319 14.1073399,2.09890307 C14.370162,2.20999509 14.6124442,2.37873129 14.8359534,2.60091534 L14.8359534,2.05362699 Z M13.5211804,3.07598282 C13.133573,3.07598282 12.8113399,3.2120319 12.5566896,3.48545521 C12.3002724,3.75755337 12.1719534,4.10761472 12.1719534,4.53453497 C12.1719534,4.96432638 12.3018184,5.31770061 12.5628736,5.59598282 C12.8241497,5.87271902 13.1443951,6.01163926 13.5258184,6.01163926 C13.9182847,6.01163926 14.244935,5.87581104 14.5028982,5.60216687 C14.7624074,5.33006871 14.8922724,4.9722773 14.8922724,4.52967607 C14.8922724,4.09679264 14.7624074,3.74673129 14.5028982,3.47772515 C14.244935,3.21048589 13.9167387,3.07598282 13.5211804,3.07598282 L13.5211804,3.07598282 Z" id="Fill-6"></path>
                              <path d="M20.0543853,2.75869693 L19.2820417,3.53567853 C18.9695264,3.22294233 18.6848393,3.06657423 18.4286429,3.06657423 C18.2895018,3.06657423 18.1799558,3.09616933 18.1002258,3.15580123 C18.0204957,3.21499141 17.9814037,3.28853742 17.9814037,3.37599755 C17.9814037,3.44335951 18.0065816,3.50431656 18.0564957,3.56063558 C18.1066307,3.6169546 18.2316368,3.69337178 18.430189,3.79187485 L18.8867043,4.02002209 C19.3681767,4.2563411 19.699465,4.49840245 19.8792442,4.74399755 C20.0590233,4.99091779 20.1480294,5.27869693 20.1480294,5.60998528 C20.1480294,6.05081963 19.9854773,6.41987485 19.660373,6.71361718 C19.3352687,7.00912638 18.8990724,7.1562184 18.3520049,7.1562184 C17.6267043,7.1562184 17.0451828,6.8730773 16.6120785,6.3056908 L17.3826552,5.46775215 C17.5297472,5.63825521 17.7015755,5.77717546 17.9003485,5.88208344 C18.0971337,5.98677055 18.2722748,6.03977669 18.4255509,6.03977669 C18.5896491,6.03977669 18.7241521,6.00090552 18.8242012,5.9209546 C18.9257963,5.8414454 18.9757104,5.75067239 18.9757104,5.64753129 C18.9757104,5.45516319 18.7943853,5.26765399 18.430189,5.08632883 L18.0096736,4.87518773 C17.2028761,4.47035337 16.7995877,3.96392393 16.7995877,3.35589939 C16.7995877,2.96343313 16.9513178,2.62728589 17.2545571,2.34900368 C17.5577963,2.07072147 17.9456245,1.93158037 18.4176,1.93158037 C18.7411583,1.93158037 19.0443975,2.00358037 19.3306307,2.1458135 C19.6150969,2.28804663 19.8558331,2.49278282 20.0543853,2.75869693" id="Fill-8"></path>
                              <path d="M25.7823828,4.89557301 L21.7726896,4.89557301 C21.8303337,5.25049325 21.9851558,5.5334135 22.235389,5.7445546 C22.4854012,5.95392883 22.8058675,6.05861595 23.1936957,6.05861595 C23.6594871,6.05861595 24.0581374,5.89451779 24.3927387,5.56632147 L25.4400515,6.06170798 C25.1789963,6.43385521 24.8647141,6.70882454 24.5005178,6.88882454 C24.1347755,7.06705767 23.7016712,7.1560638 23.1998798,7.1560638 C22.4213521,7.1560638 21.7868245,6.91068957 21.2974012,6.41817423 C20.8081988,5.92720491 20.5626037,5.31145031 20.5626037,4.57201472 C20.5626037,3.81380613 20.8081988,3.18391656 21.2974012,2.68367117 C21.7868245,2.18187975 22.3994871,1.93164663 23.1389227,1.93164663 C23.9220883,1.93164663 24.5599288,2.18187975 25.0506773,2.68057914 C25.5416466,3.18060368 25.7870209,3.83876319 25.7870209,4.65969571 L25.7823828,4.89557301 Z M24.5396098,3.92003926 C24.4567877,3.64816196 24.2942356,3.42619877 24.0519534,3.25569571 C23.8081252,3.0854135 23.5265301,3.00082454 23.2045178,3.00082454 C22.8560025,3.00082454 22.5512172,3.09623558 22.2868491,3.28860368 C22.1227509,3.40742577 21.9694748,3.61834601 21.8290086,3.92003926 L24.5396098,3.92003926 Z" id="Fill-10"></path>
                              <path d="M30.3152687,0.10083681 L32.3864834,0.10083681 L27.5638086,8.39232147 C27.4359313,8.61251779 27.1510233,8.79251779 26.9310479,8.79251779 L24.8596123,8.79251779 L29.6822871,0.501033129 C29.8103853,0.28083681 30.0950724,0.10083681 30.3152687,0.10083681" id="Fill-12"></path>
                              <path d="M33.8695067,0.10083681 L35.9409423,0.10083681 L31.1182675,8.39232147 C30.9901693,8.61251779 30.7054822,8.79251779 30.4852859,8.79251779 L28.4138503,8.79251779 L33.2365252,0.501033129 C33.3646233,0.28083681 33.6493104,0.10083681 33.8695067,0.10083681" id="Fill-15"></path>
                          </g>
                          <path d="M1.40908957,7 L1.40908957,4.89772928 L2.65908837,4.89772928 C4.01135981,4.89772928 4.60226834,4.06818461 4.60226834,3.02273107 C4.60226834,1.97727752 4.01135981,1.18182373 2.64772475,1.18182373 L0.704544783,1.18182373 L0.704544783,7 L1.40908957,7 Z M2.65908837,4.27272987 L1.40908957,4.27272987 L1.40908957,1.80682313 L2.64772475,1.80682313 C3.59090567,1.80682313 3.90908957,2.30682313 3.90908957,3.02273107 C3.90908957,3.73863947 3.59090567,4.27272987 2.65908837,4.27272987 Z M7.45454318,7.090909 C8.63636023,7.090909 9.43181402,6.19318259 9.43181402,4.84091115 C9.43181402,3.47727609 8.63636023,2.57954967 7.45454318,2.57954967 C6.27272612,2.57954967 5.47727234,3.47727609 5.47727234,4.84091115 C5.47727234,6.19318259 6.27272612,7.090909 7.45454318,7.090909 Z M7.45454318,6.48863685 C6.55681676,6.48863685 6.14772624,5.71591032 6.14772624,4.84091115 C6.14772624,3.96591198 6.55681676,3.18182182 7.45454318,3.18182182 C8.3522696,3.18182182 8.76136011,3.96591198 8.76136011,4.84091115 C8.76136011,5.71591032 8.3522696,6.48863685 7.45454318,6.48863685 Z M12.1022706,7 L13.0568151,3.64773047 L13.1249969,3.64773047 L14.0795414,7 L14.7386317,7 L16.0681759,2.6363678 L15.3636311,2.6363678 L14.4204502,5.96591008 L14.3749957,5.96591008 L13.454542,2.6363678 L12.7386336,2.6363678 L11.8068163,5.9772737 L11.7613618,5.9772737 L10.8181809,2.6363678 L10.1136361,2.6363678 L11.4431803,7 L12.1022706,7 Z M18.7840886,7.090909 C19.6704514,7.090909 20.318178,6.64772761 20.5227233,5.98863733 L19.8749966,5.80681932 C19.7045422,6.26136434 19.318179,6.48863685 18.7840886,6.48863685 C17.9943166,6.48863685 17.497158,5.98863733 17.4289762,5.04545641 L20.590905,5.04545641 L20.590905,4.76136577 C20.590905,3.13636732 19.6249969,2.57954967 18.7159068,2.57954967 C17.5340898,2.57954967 16.7499996,3.51136696 16.7499996,4.85227478 C16.7499996,6.19318259 17.5227261,7.090909 18.7840886,7.090909 Z M19.9090875,4.46591151 L17.4431808,4.46591151 C17.5511352,3.64773047 18.0454529,3.18182182 18.7159068,3.18182182 C19.4431808,3.18182182 19.9090875,3.72727585 19.9090875,4.46591151 Z M22.2954533,7 L22.2954533,4.53409326 C22.3068169,3.94318473 22.7159075,3.2613672 23.4318159,3.2613672 C23.6249994,3.2613672 23.7386338,3.31818533 23.8068155,3.35227621 L24.034088,2.7272768 C23.8977245,2.64773142 23.6818156,2.56818604 23.4545431,2.56818604 C22.94318,2.56818604 22.4659077,2.96591294 22.3409078,3.38636708 L22.2954533,3.38636708 L22.2954533,2.6363678 L21.6249994,2.6363678 L21.6249994,7 L22.2954533,7 Z M26.5454522,7.090909 C27.431815,7.090909 28.0795417,6.64772761 28.2840869,5.98863733 L27.6363603,5.80681932 C27.4659059,6.26136434 27.0795426,6.48863685 26.5454522,6.48863685 C25.7556802,6.48863685 25.2585216,5.98863733 25.1903399,5.04545641 L28.3522687,5.04545641 L28.3522687,4.76136577 C28.3522687,3.13636732 27.3863605,2.57954967 26.4772705,2.57954967 C25.2954534,2.57954967 24.5113632,3.51136696 24.5113632,4.85227478 C24.5113632,6.19318259 25.2840898,7.090909 26.5454522,7.090909 Z M27.6704511,4.46591151 L25.2045444,4.46591151 C25.3124988,3.64773047 25.8068166,3.18182182 26.4772705,3.18182182 C27.2045444,3.18182182 27.6704511,3.72727585 27.6704511,4.46591151 Z M31.0340888,7.090909 C31.874997,7.090909 32.1704513,6.56818223 32.3181784,6.32954609 L32.3863602,6.32954609 L32.3863602,7 L33.0340868,7 L33.0340868,1.18182373 L32.3636329,1.18182373 L32.3636329,3.32954895 L32.3181784,3.32954895 C32.1704513,3.10227644 31.8977243,2.57954967 31.0454524,2.57954967 C29.9431807,2.57954967 29.1818178,3.45454884 29.1818178,4.82954752 C29.1818178,6.21590984 29.9431807,7.090909 31.0340888,7.090909 Z M31.1249978,6.48863685 C30.2840895,6.48863685 29.8522717,5.75000119 29.8522717,4.8181839 C29.8522717,3.89773023 30.2727258,3.18182182 31.1249978,3.18182182 C31.9431788,3.18182182 32.3749966,3.8409121 32.3749966,4.8181839 C32.3749966,5.80681932 31.9318152,6.48863685 31.1249978,6.48863685 Z M38.5113631,7.090909 C39.6022692,7.090909 40.3636321,6.21590984 40.3636321,4.82954752 C40.3636321,3.45454884 39.6022692,2.57954967 38.4999975,2.57954967 C37.6477256,2.57954967 37.3863622,3.10227644 37.2386351,3.32954895 L37.181817,3.32954895 L37.181817,1.18182373 L36.5113631,1.18182373 L36.5113631,7 L37.1590897,7 L37.1590897,6.32954609 L37.2386351,6.32954609 C37.3863622,6.56818223 37.6704529,7.090909 38.5113631,7.090909 Z M38.4204521,6.48863685 C37.6136347,6.48863685 37.1704533,5.80681932 37.1704533,4.8181839 C37.1704533,3.8409121 37.6022711,3.18182182 38.4204521,3.18182182 C39.2727241,3.18182182 39.6931782,3.89773023 39.6931782,4.8181839 C39.6931782,5.75000119 39.2613604,6.48863685 38.4204521,6.48863685 Z M41.7954536,8.6931802 C42.3977257,8.6931802 42.8295435,8.37499869 43.0795433,7.70454478 L44.9545415,2.6363678 L44.2272694,2.6363678 L43.0227251,6.11363721 L42.9744297,6.11363721 L41.7727263,2.6363678 L41.0454543,2.6363678 L42.6647709,7.02840906 L42.511362,7.43181777 C42.2613622,8.07954443 41.9545443,8.1363678 41.4772721,8.0227263 L41.3068177,8.61363482 C41.3749994,8.6477257 41.5681811,8.6931802 41.7954536,8.6931802 Z" id="Poweredby" fill-rule="nonzero"></path>
                      </g>
                  </g>
              </g>
          </svg>
        </div>
      </div>

    </div>
  </div>
</body>
</html>
</#macro>