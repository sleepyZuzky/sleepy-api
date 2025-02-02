import type { Schema, Struct } from '@strapi/strapi';

export interface DevProjectTecnologies extends Struct.ComponentSchema {
  collectionName: 'components_dev_project_tecnologies';
  info: {
    description: '';
    displayName: 'project_tecnologies';
    icon: 'code';
  };
  attributes: {
    color: Schema.Attribute.String &
      Schema.Attribute.CustomField<'plugin::color-picker.color'>;
    family: Schema.Attribute.Enumeration<
      ['classic', 'sharp', 'duotone', 'brands']
    >;
    icon_name: Schema.Attribute.String;
    label: Schema.Attribute.String;
    variant: Schema.Attribute.Enumeration<
      ['thin', 'light', 'regular', 'solid']
    >;
  };
}

export interface RrssOverlay extends Struct.ComponentSchema {
  collectionName: 'components_rrss_overlays';
  info: {
    displayName: 'Overlay';
    icon: 'globe';
  };
  attributes: {
    label: Schema.Attribute.String;
    link: Schema.Attribute.String;
  };
}

export interface RrssOwners extends Struct.ComponentSchema {
  collectionName: 'components_rrss_owners';
  info: {
    description: '';
    displayName: 'owners';
    icon: 'user';
  };
  attributes: {
    appearance: Schema.Attribute.Enumeration<
      ['outlined accent', 'accent', 'outlined', 'filled', 'outlined filled']
    > &
      Schema.Attribute.DefaultTo<'outlined accent'>;
    label: Schema.Attribute.String;
    socials: Schema.Attribute.String;
    variant: Schema.Attribute.Enumeration<
      ['brand', 'success', 'neutral', 'warning', 'danger']
    > &
      Schema.Attribute.DefaultTo<'brand'>;
  };
}

declare module '@strapi/strapi' {
  export module Public {
    export interface ComponentSchemas {
      'dev.project-tecnologies': DevProjectTecnologies;
      'rrss.overlay': RrssOverlay;
      'rrss.owners': RrssOwners;
    }
  }
}
