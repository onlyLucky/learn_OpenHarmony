import EnterpriseAdminExtensionAbility from '@ohos.enterprise.EnterpriseAdminExtensionAbility';
import Logger from '../common/Logger';
export default class EnterpriseAdminAbility extends EnterpriseAdminExtensionAbility {
    onAdminEnabled() {
        Logger.info("onAdminEnabled");
    }
    onAdminDisabled() {
        Logger.info("onAdminDisabled");
    }
    onBundleAdded(bundleName) {
        Logger.info("EnterpriseAdminAbility", "onBundleAdded bundleName:" + bundleName);
    }
    onBundleRemoved(bundleName) {
        Logger.info("EnterpriseAdminAbility", "onBundleRemoved bundleName" + bundleName);
    }
}
;
//# sourceMappingURL=index.js.map