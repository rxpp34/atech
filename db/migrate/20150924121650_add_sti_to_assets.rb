class AddStiToAssets < ActiveRecord::Migration
  def change
    change_table :assets do |t|
      t.string :type
      t.integer :quantity
    end

    Asset.where(name: ['ANTIVIRUS', 'KAPERSKY', 'ESET'])
      .update_all type: AntivirusAsset

    Asset.where(name: ['SERVEUR', 'SERVEUR VM', 'SERV-PMSI', 'SAUVEGARDE'])
      .update_all type: ServerAsset

    Asset.where(name: ['LOGICIEL MAIL'])
      .update_all type: MailSoftwareAsset

    Asset.where(name: ['FIREWALL'])
      .update_all type: FirewallAsset

    Asset.where(name: ['DOMAINE'])
      .update_all type: DomainAsset

    Asset.where(type: nil)
      .update_all type: UncategorizedAsset

  end
end
