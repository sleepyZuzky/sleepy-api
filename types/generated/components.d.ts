import type { Schema, Struct } from '@strapi/strapi';

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

declare module '@strapi/strapi' {
  export module Public {
    export interface ComponentSchemas {
      'rrss.overlay': RrssOverlay;
    }
  }
}
