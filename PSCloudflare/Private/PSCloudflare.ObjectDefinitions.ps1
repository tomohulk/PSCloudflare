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
#endregion Enums


#region Classes
Class CloudflareZone {
    [String]$ID
    [String]$Name
    [String]$DevelopmentMode
    [String[]]$OriginalNameServers
    [String]$OriginalRegistrar
    [String]$OriginalDNSHost
    [DateTime]$CreatedOn
    [DateTime]$ModifiedOn
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
    [DateTime]$CreatedOn
    [DateTime]$ModifiedOn

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
    [DateTime]$CreatedOn

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
#endregion Classes
