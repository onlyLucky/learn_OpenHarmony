/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import hilog from '@ohos.hilog';
class Logger {
    constructor(prefix) {
        this.prefix = 'Sample_Enterprise';
        this.format = '%{public}s, %{public}s';
        this.prefix = prefix;
        this.domain = 0x5022;
    }
    debug(...args) {
        hilog.debug(this.domain, this.prefix, this.format, args);
    }
    info(...args) {
        hilog.info(this.domain, this.prefix, this.format, args);
    }
    warn(...args) {
        hilog.warn(this.domain, this.prefix, this.format, args);
    }
    error(...args) {
        hilog.error(this.domain, this.prefix, this.format, args);
    }
    isLoggable(...args) {
        hilog.isLoggable(this.domain, this.prefix, hilog.LogLevel.INFO);
    }
}
export default new Logger('[samples.enterprise_admin_ext_ability]');
//# sourceMappingURL=Logger.js.map