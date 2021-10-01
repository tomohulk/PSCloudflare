#region Enums
Enum CloudflareZoneType {
    Full
    Partial
}

Enum CloudflareZoneStatus {
    Active
    Pending
    Initalizing
    Moved
    Deleted
    Deactivted
}

Enum CloudflareZoneDNSRecordType {
    A
    AAAA
    CNAME
    HTTPS
    TXT
    SRV
    LOC
    MX
    NS
    SPF
    CERT
    DNSKEY
    DS
    NAPTR
    SMIMEA
    SSHFP
    SVCB
    TLSA
    URI
}

Enum CloudflareZonePageRuleStatus {
    Active
    Disabled
}

Enum CloudflareZoneWAFPackageSensitivity {
    High
    Medium
    Low
    Off
}

Enum CloudflareZoneWAFPackageActionMode {
    Simulate
    Block
    Challenge
}
#endregion Enums


#region Classes
Class CloudflareZone {
    [String]$ID
    [String]$Name
    [String]$DevelopmentMode
    [String[]]$OriginalNameServers
    [String]$OriginalRegistrar
    [String]$OriginalDNSHost
    [Nullable[DateTime]]$CreatedOn
    [Nullable[DateTime]]$ModifiedOn
    [Nullable[DateTime]]$ActivatedOn
    [String[]]$VanityNameServers
    [String[]]$VanityNameServersIPs
    [CloudflareZoneMeta]$Meta
    [CloudflareZoneOwner]$Owner
    [CloudflareZoneAccount]$Account
    [String[]]$Permissions
    [CloudflareZonePlan]$Plan
    [CloudflareZonePlan]$PlanPending
    [CloudflareZoneStatus]$Status
    [Bool]$Paused
    [CloudflareZoneType]$Type
    [String[]]$NameServers

    CloudflareZone([Object]$object) {
        $this.ID = $object.id
        $this.Name = $object.name
        $this.DevelopmentMode = $object.development_mode
        $this.OriginalNameServers = $object.original_name_servers
        $this.OriginalRegistrar = $object.original_registrar
        $this.OriginalDNSHost = $object.original_dnshost
        $this.CreatedOn = $object.created_on
        $this.ModifiedOn = $object.modified_on
        $this.ActivatedOn = $object.activated_on
        $this.VanityNameServers = $object.vanity_name_servers
        $this.VanityNameServersIPs = $object.vanity_name_servers_ips
        $this.Meta = $object.meta
        $this.Owner = $object.owner
        $this.Account = $object.account
        $this.Permissions = $object.permissions
        $this.Plan = $object.plan
        $this.PlanPending = $object.plan_pending
        $this.Status = $object.Status
        $this.Paused = $object.paused
        $this.Type = $object.type
        $this.NameServers = $object.name_servers
    }
}

Class CloudflareZoneMeta {
    [Int]$Step
    [Bool]$WildcardProxiable
    [Int]$CustomCertificateQuota
    [Int]$PageRuleQuota
    [Bool]$PhishingDetected
    [Bool]$MultipuleRailgunsAllowed

    CloudflareZoneMeta([Object]$object) {
        $this.Step = $object.step
        $this.WildcardProxiable = $object.wildcart_proxiable
        $this.CustomCertificateQuota = $object.custom_certificate_quota
        $this.PageRuleQuota = $object.page_rule_quota
        $this.PhishingDetected = $object.phishing_detected
        $this.MultipuleRailgunsAllowed = $object.multipule_railguns_allowed
    }
}

Class CloudflareZoneOwner {
    [String]$ID
    [String]$Name

    CloudflareZoneOwner([Object]$object) {
        $this.ID = $object.id
        $this.Name = $object.name
    }
}

Class CloudflareZoneAccount {
    [String]$ID
    [String]$Name

    CloudflareZoneAccount([Object]$object) {
        $this.ID = $object.id
        $this.Name = $object.name
    }
}

Class CloudflareZonePlan {
    [String]$ID
    [String]$Name
    [Int]$Price
    [String]$Currency
    [String]$Frequency
    [String]$LegacyID
    [Bool]$LegacyDiscount
    [Bool]$IsSubscribed
    [Bool]$CanSubscribe
    [Bool]$ExternallyManaged

    CloudflareZonePlan([Object]$object) {
        $this.ID = $object.id
        $this.Name = $object.name
        $this.Price = $object.price
        $this.Currency = $object.currency
        $this.Frequency = $object.frequency
        $this.LegacyID = $object.legacy_id
        $this.LegacyDiscount = $object.legacy_discount
        $this.IsSubscribed = $object.is_subscribed
        $this.CanSubscribe = $object.can_subscribe
        $this.ExternallyManaged = $object.exteranlly_managed
    }
}

Class CloudflareZoneDNSRecord {
    [String]$ID
    [CloudflareZoneDNSRecordType]$Type
    [String]$Name
    [String]$Content
    [Bool]$Proxiable
    [Bool]$Proxied
    [Int]$TTL
    [Bool]$Locked
    [CloudflareZoneDNSRecordMeta]$Meta
    [String]$ZoneID
    [String]$ZoneName
    [Nullable[DateTime]]$CreatedOn
    [Nullable[DateTime]]$ModifiedOn

    CloudflareZoneDNSRecord([Object]$object) {
        $this.ID = $object.id
        $this.Type = $object.type
        $this.Name = $object.name
        $this.Content = $object.content
        $this.Proxiable = $object.proxiable
        $this.Proxied = $object.proxied
        $this.TTL = $object.ttl
        $this.Locked = $object.locked
        $this.Meta = $object.meta
        $this.ZoneID = $object.zone_id
        $this.ZoneName = $object.zone_name
        $this.CreatedOn = $object.created_on
        $this.ModifiedOn = $object.modified_on
    }
}

Class CloudflareZoneDNSRecordMeta {
    [Bool]$AutoAdded
    [Bool]$ManagedByApps
    [Bool]$ManagedByArgoTunnel
    [String]$Source

    CloudflareZoneDNSRecordMeta([Object]$object) {
        $this.AutoAdded = $object.auto_added
        $this.ManagedByApps = $object.managed_by_apps
        $this.ManagedByArgoTunnel = $object.managed_by_argo_tunnel
        $this.Source = $object.source
    }
}

Class CloudflareZoneDNSRecordImport {
    [Int]$RecordsAdded
    [Int]$TotalRecordsParsed
    [CloudflareZoneDNSRecordImportTiming]$Timing

    CloudflareZoneDNSRecordImport([Object]$object) {
        $this.RecordsAdded = $object.recs_added
        $this.TotalRecordsParsed = $object.total_records_parsed
        $this.Timing = $object.timing
    }
}

Class CloudflareZoneDNSRecordImportTiming {
    [Nullable[DateTime]]$StartTime
    [Nullable[DateTime]]$EndTime
    [Int]$ProcessTime

    CloudflareZoneDNSRecordImportTiming([Object]$object) {
        $this.StartTime = $object.start_time
        $this.EndTime = $object.end_time
        $this.ProcessTime = $object.process_time
    }
}

Class CloudflareZoneSubscription {
    [String]$ID
    [CloudflareSubscriptionProduct]$Product
    [CloudflareSubscriptionRatePlan]$RatePlan
    [CloudflareSubscriptionComponent[]]$ComponentValues
    [CloudflareSubscriptionZoneDetails]$Zone
    [String]$Frequency
    [String]$Currency
    [CloudflareSubscriptionApp]$App
    [Bool]$Entitled
    [Bool]$CancelAtPeriodEnd

    CloudflareZoneSubscription([Object]$object) {
        $this.ID = $object.id
        $this.Product = $object.product
        $this.RatePlan = $object.rate_plan
        $this.ComponentValues = $object.component_values
        $this.Zone = $object.zone
        $this.Frequency = $object.frequency
        $this.Currency = $object.currency
        $this.App = $object.app
        $this.Entitled = $object.entitled
        $this.CancelAtPeriodEnd = $object.cancel_at_period_end
    }
}

Class CloudflareSubscriptionProduct {
    [String]$Name
    [Object]$Period
    [Object]$Billing
    [String]$PublicName
    [Int]$Duration

    CloudflareSubscriptionProduct([Object]$object) {
        $this.Name = $object.name
        $this.Period = $object.period
        $this.Billing = $object.billing
        $this.PublicName = $object.public_name
        $this.Duration = $object.duration
    }
}

Class CloudflareSubscriptionRatePlan {
    [String]$ID
    [String]$PublicName
    [String]$Currency
    [String]$Scope
    [Object[]]$Sets
    [Bool]$IsContract
    [Bool]$ExternallyManaged

    CloudflareSubscriptionRatePlan([Object]$object) {
        $this.ID = $object.id
        $this.PublicName = $object.public_name
        $this.Currency = $object.currency
        $this.Scope = $object.scope
        $this.Sets = $object.sets
        $this.IsContract = $object.is_contract
        $this.ExternallyManaged = $object.externally_managed
    }
}

Class CloudflareSubscriptionComponent {
    [String]$Name
    [Int]$Value
    [Int]$Default
    [Int]$Price

    CloudflareSubscriptionComponent([Object]$object) {
        $this.Name = $object.name
        $this.Value = $object.value
        $this.Default = $object.default
        $this.Price = $object.price
    }
}

Class CloudflareSubscriptionZoneDetails {
    [String]$ID
    [String]$Name

    CloudflareSubscriptionZoneDetails([Object]$object) {
        $this.ID = $object.id
        $this.Name = $object.name
    }
}

Class CloudflareSubscriptionApp {
    [String]$InstallID

    CloudflareSubscriptionApp([Object]$object) {
        $this.InstallID = $object.install_id
    }
}

Class CloudflareZoneRatePlan {
    [String]$ID
    [String]$Name
    [String]$Currency
    [Int]$Duration
    [String]$Frequency
    [CloudflareZoneRatePlanComponent[]]$Components

    CloudflareZoneRatePlan([Object]$object) {
        $this.ID = $object.id
        $this.Name = $object.name
        $this.Currency = $object.currency
        $this.Duration = $object.duration
        $this.Frequency = $object.frequency
        $this.Components = $object.components
    }
}

Class CloudflareZoneRatePlanComponent {
    [String]$Name
    [Int]$Default
    [Int]$Price

    CloudflareZoneRatePlanComponent([Object]$object) {
        $this.Name = $object.name
        $this.Default = $object.default
        $this.Price = $object.price
    }
}

Class CloudflareAccount {
    [String]$ID
    [String]$Name
    [CloudflareAccountSettings]$Settings
    [Nullable[DateTime]]$CreatedOn

    CloudflareAccount([Object]$object) {
        $this.ID = $object.id
        $this.Name = $object.name
        $this.Settings = $object.settings
        $this.CreatedOn = $object.created_on
    }
}

Class CloudflareAccountSettings {
    [Bool]$EnforceTwoFactor
    [Bool]$UseAccountCustomNSByDefault

    CloudflareAccountSettings([Object]$object) {
        $this.EnforceTwoFactor = $object.enforce_twofactor
        $this.UseAccountCustomNSByDefault = $object.use_account_custom_ns_by_default
    }
}

Class CloudflareOrganization {
    [String]$ID
    [String]$Name
    [String]$Status
    [String[]]$Permissions
    [String[]]$Roles

    CloudflareOrganization([Object]$object) {
        $this.ID = $object.id
        $this.Name = $object.name
        $this.Status = $object.status
        $this.Permissions = $object.permissions
        $this.Roles = $object.Roles
    }
}

Class CloudflareZonePageRule {
    [String]$ID
    [CloudflareZonePageRuleTarget[]]$Target
    [CloudflareZonePageRuleAction[]]$Action
    [Int]$Priority
    [String]$Status
    [Nullable[DateTime]]$ModifiedOn
    [Nullable[DateTime]]$CreatedOn

    CloudflareZonePageRule([Object]$object) {
        $this.ID = $object.id
        $this.Target = $object.targets
        $this.Action = $object.actions
        $this.Priority = $object.priority
        $this.Status = $object.status
        $this.ModifiedOn = $object.modified_on
        $this.CreatedOn = $object.created_on
    }
}

Class CloudflareZonePageRuleTarget {
    [String]$Target
    [CloudflareZonePageRuleTargetConstraint]$Constraint

    CloudflareZonePageRuleTarget([Object]$object) {
        $this.Target = $object.target
        $this.Constraint = $object.constraint
    }
}

Class CloudflareZonePageRuleTargetConstraint {
    [String]$Operator
    [String]$Value

    CloudflareZonePageRuleTargetConstraint([Object]$object) {
        $this.Operator = $object.operator
        $this.Value = $object.value
    }
}

Class CloudflareZonePageRuleAction {
    [String]$ID
    [Object]$Value

    CloudflareZonePageRuleAction([Object]$object) {
        $this.ID = $object.id
        $this.Value = $object.value
    }
}

Class CloudflareZoneWAFRuleGroup {
    [String]$ID
    [String]$Name
    [String]$Description
    [Int]$RulesCount
    [Int]$ModifiedRulesCount
    [String]$PackageID
    [String]$Mode
    [String[]]$AllowedModes

    CloudflareZoneWAFRuleGroup([Object]$object) {
        $this.ID = $object.id
        $this.Name = $object.name
        $this.Description = $object.description
        $this.RulesCount = $object.rules_count
        $this.ModifiedRulesCount = $object.modified_rules_count
        $this.PackageID = $object.package_id
        $this.Mode = $object.mode
        $this.AllowedModes = $object.allowed_modes
    }
}

Class CloudflareZoneWAFPackage {
    [String]$ID
    [String]$Name
    [String]$Description
    [String]$DetectionMode
    [String]$ZoneID
    [String]$Status
    [Nullable[CloudflareZoneWAFPackageSensitivity]]$Sensitivity
    [Nullable[CloudflareZoneWAFPackageActionMode]]$ActionMode

    CloudflareZoneWAFPackage([Object]$object) {
        $this.ID = $object.id
        $this.Name = $object.name
        $this.Description = $object.description
        $this.DetectionMode = $object.detection_mode
        $this.ZoneID = $object.zone_id
        $this.Status = $object.status
        $this.Sensitivity = $object.sensitivity
        $this.ActionMode = $object.action_mode
    }
}

Class CloudflareZoneSetting {
    [String]$ID
    [Object]$Value
    [Nullable[DateTime]]$ModifiedOn
    [Bool]$Editable
    [Nullable[Int]]$TimeRemaining

    CloudflareZoneSetting([Object]$object) {
        $this.ID = $object.id
        $this.Value = $object.value
        $this.ModifiedOn = $object.modified_on
        $this.Editable = $object.editable
        $this.TimeRemaining = $object.time_remaining
    }
}

Class CloudflareZoneSettingIDBinding : System.Management.Automation.IValidateSetValuesGenerator {
    [String[]]GetValidValues() {
        $Global:CloudflareZoneSettingIDBinding = @{
            '0RTT' = '0rtt'
            'AdvancedDDOS' = 'advanced_ddos'
            'AlwaysOnline' = 'always_online'
            'AlwaysUseHTTPS' = 'always_use_https'
            'AutomaticHTTPSRewrite' = 'automatic_https_rewrites'
            'AutomaticPlatformOptimization' = 'automatic_platform_optimization'
            'Brotli' = 'brotli'
            'BrowserCacheTTL' = 'browser_cache_ttl'
            'BrowserCheck' = 'browser_check'
            'CacheLevel' = 'cache_level'
            'ChallengeTTL' = 'challenge_ttl'
            'Chipers' = 'chipers'
            'DevelopmentMode' = 'development_mode'
            'EmailObfuscation' = 'email_obfuscation'
            'H2Prioritization' = 'h2_prioritization'
            'HotlinkProtection' = 'hotlink_protection'
            'HTTP2' = 'http2'
            'HTTP3' = 'http3'
            'ImageResizing' = 'imaging_resizing'
            'IPGeolocation' = 'ip_geolocation'
            'IPv6' = 'ipv6'
            'Minify' = 'minify'
            'MobileRedirec' = 'mobile_redirect'
            'Mirage' = 'mirage'
            'OpportunisticOnion' = 'opportunistic_onion'
            'OrangeToOrange' = 'orange_to_orange'
            'OriginErrorPagePassThru' = 'origin_page_error_page_pass_thru'
            'OpportunisticEncryption' = 'opportunistic_encryption'
            'PrefetchPreload' = 'prefetch_preload'
            'PrivacyPass' = 'privacy_pass'
            'Polish' = 'polish'
            'PseudoIPv4' = 'pseudo_ipv4'
            'ResponseBuffering' = 'response_buffering'
            'RocketLoader' = 'rocket_loader'
            'SecurityHeader' = 'security_header'
            'SecurityLevel' = 'security_level'
            'ServerSideExclude' = 'server_side_exclude'
            'SortQueryStringForCache' = 'sort_query_string_for_cache'
            'SSL' = 'ssl'
            'SSLRecommender' = 'ssl_recommender'
            'MinimumTLSVersion' = 'min_tls_version'
            'TLS1.3' = 'tls_1_3'
            'TLSClientAuth' = 'tls_client_auth'
            'TrueClientIPHeader' = 'true_client_ip_header'
            'WAF' = 'waf'
            'WebP' = 'webp'
            'WebSocket' = 'websockets'
        }

        return ($Global:CloudflareZoneSettingIDBinding).Keys
    }
}
#endregion Classes
