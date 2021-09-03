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
    [CloudflareOwner]$Owner
    [CloudflareAccount]$Account
    #[CloudFlarePermission[]]$Permissions
    [CloudflarePlan]$Plan
    [CloudflarePlan]$PlanPending
    [String]$Status
    [Bool]$Paused
    [String]$Type
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
        $this.Owner = $object.owner
        $this.Account = $object.account
        #$this.Permissions = $object.permissions
        $this.Plan = $object.plan
        $this.PlanPending = $object.plan_pending
        $this.Status = $object.Status
        $this.Paused = $object.paused
        $this.Type = $object.type
        $this.NameServers = $object.name_servers
    }
}

Class CloudflareOwner {
    [String]$ID
    [String]$Name

    CloudflareOwner([Object]$object) {
        $this.ID = $object.id
        $this.Name = $object.name
    }
}

Class CloudflareAccount {
    [String]$ID
    [String]$Name

    CloudflareAccount([Object]$object) {
        $this.ID = $object.id
        $this.Name = $object.name
    }
}

Class CloudflarePlan {
    [String]$ID
    [String]$Name
    [Int]$Price
    [String]$Currency
    [String]$Frequency
    [String]$LegacyID
    [Bool]$IsSubscribed
    [Bool]$CanSubscribe

    CloudflarePlan([Object]$object) {
        $this.ID = $object.id
        $this.Name = $object.name
        $this.Price = $object.price
        $this.Currency = $object.currency
        $this.Frequency = $object.frequency
        $this.LegacyID = $object.legacy_id
        $this.IsSubscribed = $object.is_subscribed
        $this.CanSubscribe = $object.can_subscribe
    }
}

Class CloudflareDNSRecord {
    [String]$ID
    [String]$Type
    [String]$Name
    [String]$Content
    [Bool]$Proxiable
    [Bool]$Proxied
    [Int]$TTL
    [Bool]$Locked
    [CloudflareDNSRecordMeta]$Meta
    [String]$ZoneID
    [String]$ZoneName
    [DateTime]$CreatedOn
    [DateTime]$ModifiedOn

    CloudflareDNSRecord([Object]$object) {
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

Class CloudflareDNSRecordMeta {
    [Bool]$AutoAdded
    [Bool]$ManagedByApps
    [Bool]$ManagedByArgoTunnel
    [String]$Source

    CloudflareDNSRecordMeta([Object]$object) {
        $this.AutoAdded = $object.auto_added
        $this.ManagedByApps = $object.managed_by_apps
        $this.ManagedByArgoTunnel = $object.managed_by_argo_tunnel
        $this.Source = $object.source
    }
}

Class CloudflareZoneSubscription {
    [String]$ID
    [CloudflareProduct]$Product
    [CloudflareRatePlan]$RatePlan
    [CloudflareComponent[]]$ComponentValues
    [CloudflareSubscriptionZoneDetails]$Zone
    [String]$Frequency
    [String]$Currency
    [CloudflareApp]$App
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

Class CloudflareProduct {
    [String]$Name
    [Object]$Period
    [Object]$Billing
    [String]$PublicName
    [Int]$Duration

    CloudflareProduct([Object]$object) {
        $this.Name = $object.name
        $this.Period = $object.period
        $this.Billing = $object.billing
        $this.PublicName = $object.public_name
        $this.Duration = $object.duration
    }
}

Class CloudflareRatePlan {
    [String]$ID
    [String]$PublicName
    [String]$Currency
    [String]$Scope
    [Object[]]$Sets
    [Bool]$IsContract
    [Bool]$ExternallyManaged

    CloudflareRatePlan([Object]$object) {
        $this.ID = $object.id
        $this.PublicName = $object.public_name
        $this.Currency = $object.currency
        $this.Scope = $object.scope
        $this.Sets = $object.sets
        $this.IsContract = $object.is_contract
        $this.ExternallyManaged = $object.externally_managed
    }
}

Class CloudflareComponent {
    [String]$Name
    [Int]$Value
    [Int]$Default
    [Int]$Price

    CloudflareComponent([Object]$object) {
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

Class CloudflareApp {
    [String]$InstallID

    CloudflareApp([Object]$object) {
        $this.InstallID = $object.install_id
    }
}
